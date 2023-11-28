library("data.table")


# Load data --------------------------------------------------------------------
base_url <- "https://static.usafacts.org/public/data/covid-19"
data_urls <- list(
  cases = paste0(base_url, "/covid_confirmed_usafacts.csv"),
  deaths = paste0(base_url, "/covid_deaths_usafacts.csv"),
  population = paste0(base_url, "/covid_county_population_usafacts.csv")
)

# specify which package to use
csv_loader <- fread

# load data
data <- lapply(data_urls, csv_loader)


# Data cleaning ----------------------------------------------------------------
# Clean column names, change all column names to lower case, and change the date
# column to the format `"year-month-day"`, e.g. `"2021-01-01"` if the date is
# not already in the this format.
for (key in names(data)) {
  names(data[[key]]) <- tolower(names(data[[key]]))
}

# Collect the date column names of both `deaths` and `cases` data frames, and
# save them into the variables `death_dates` and `case_dates`.
dates <- lapply(
  data[c("cases", "deaths")],
  function(dt) names(dt)[grep("\\d{4}-\\d{2}-\\d{2}", names(dt))]
)

# Aggregate the deaths, cases and population from each county to their state
# using sum, and re-assign them to `deaths`, `cases` and `population`.
for (key in c("cases", "deaths")) {
  data[[key]] <- data[[key]][, lapply(.SD, sum), by = state, .SDcols = dates[[key]]]
}
data[["population"]] <- data[["population"]][
  , list(population = sum(population)), by = state
]

# Reshape the `deaths` and `cases` so that each row is from a single state and a
# single date. The date column should be named `"date"` and the count column
# should be named `"deaths"` for `deaths` and `"cases"` for `cases`.
for (key in c("cases", "deaths")) {
  data[[key]] <- melt(
    data[[key]],
    id.vars = "state",
    measure.vars = dates[[key]],
    variable.name = "date",
    value.name = key,
    variable.factor = FALSE
  )
}

# Merge `deaths`, `cases` and `population` into one data frame called `counts`.
# `deaths` and cases` will be merged by matching `state` and date` and the
# `population` should be merged by matching `state`.
counts <- with(data, merge(deaths, cases, by = c("state", "date"), all = TRUE))
counts <- with(data, merge(counts, population, by = c("state"), all.x = TRUE))


# Data validation and processing -----------------------------------------------
# Order the data by state and date.
counts <- counts[order(state, date)]

# Compute the new deaths and cases for each state, by using the current day's
# count minus the yesterday's count. For the first day in the record we will
# keep the count as the "new" count. For example, if deaths is
# `c(200, 201, 205, 209)` the new deaths should be `c(200, 1, 4, 4)`.
# Column name for new deaths should be `"new_deaths"` and the column name for
# new cases should be `"new_cases"`.
for (key in c("cases", "deaths")) {
  j_expr <- parse(text = sprintf("new_%s := c(%s[1], diff(%s))", key, key, key))
  counts[, eval(j_expr), by = state]
}

# You will notice that some of the new deaths or new cases are negative. Replace
# the negative value by 0 and then re-compute the deaths and cases as the
# cumulative sum of the new deaths and new cases.
for (key in c("cases", "deaths")) {
  j_expr <- parse(text = sprintf("new_%s := pmax(new_%s, 0)", key, key))
  counts[, eval(j_expr)]
  j_expr <- parse(text = sprintf("%s := cumsum(new_%s)", key, key))
  counts[, eval(j_expr), by = state]
}

# Compute the infection fatality rate as the ratio between the deaths and cases.
# The column name should be `ifr`.
counts[, ifr := 0]
counts[cases > 0, ifr := deaths / cases]

# Compute the mortality rate as the ratio between the deaths and population.
# The column name should be `mr`.
counts[, mr := deaths / population]


# Data analysis and results ----------------------------------------------------
# List the top five states with the most deaths, cases.
# List the top five states with the highest infection fatality rate and
# mortality rate.
max_summary <- counts[, lapply(.SD, max), by = state, .SDcols = -c("date")]
top_five_states <- sapply(
  c("deaths", "cases", "ifr", "mr"),
  function(x) max_summary[order(-max_summary[[x]])]$state[1:5],
  USE.NAMES = TRUE
)
