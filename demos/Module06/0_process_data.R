rm(list = ls())
library("data.table")
library("ggplot2")
library("stringr")

# load data
base_url <- "https://static.usafacts.org/public/data/covid-19/"
data_urls <- list(
  cases = paste0(base_url, "covid_confirmed_usafacts.csv"),
  deaths = paste0(base_url, "covid_deaths_usafacts.csv"),
  population = paste0(base_url, "covid_county_population_usafacts.csv")
)

data <- lapply(data_urls, fread)

# data cleaning
for (key in names(data)) {
  names(data[[key]]) <- tolower(names(data[[key]]))
}

# melt cases and deaths
process_counts <- function(dt, count_name) {
  # melt counts
  dates <- names(dt)[grep("^\\d{4}-\\d{2}-\\d{2}$", names(dt))]
  dt <- dt[, lapply(.SD, sum), by = state, .SDcols = dates]
  dt <- melt(
    dt,
    id.vars = "state",
    measure.vars = dates,
    variable.name = "date",
    value.name = count_name,
    variable.factor = FALSE
  )
  # create new counts
  dt <- dt[order(state, date)]
  new_count_name <- paste0("new_", count_name)
  j_expr <- parse(
    text = sprintf("%s := c(%s[1], diff(%s))", new_count_name, count_name, count_name)
  )
  dt[, eval(j_expr), by = state]
  i_expr <- parse(text = sprintf("%s < 0", new_count_name))
  j_expr <- parse(text = sprintf("%s := 0", new_count_name))
  dt[eval(i_expr), eval(j_expr)]
  j_expr <- parse(text = sprintf("%s := cumsum(%s)", count_name, new_count_name))
  dt[, eval(j_expr)]
  dt
}

for (key in c("cases", "deaths")) {
  data[[key]] <- process_counts(data[[key]], key)
}

# aggregate population
data[["population"]] <- data[["population"]][,list(population = sum(population)), by = state]

# merge data
counts <- with(data, merge(deaths, cases, by = c("state", "date"), all = TRUE))
counts <- with(data, merge(counts, population, by = c("state"), all.x = TRUE))
rm(list = c("data"))

# compute rates
counts[, ifr := 0]
counts[cases > 0, ifr := deaths / cases]
counts[, mr := deaths / population]

# add complete state name
state_names <- fread("https://raw.githubusercontent.com/jasonong/List-of-US-States/master/states.csv")
names(state_names) <- c("state_name", "state")
counts <- merge(counts, state_names, by = "state")

# process state map
state_map <- setDT(map_data("state"))
state_map[, region := gsub("Of", "of", str_to_title(region))]
setnames(state_map, "region", "state_name")

# save data
fwrite(counts, "demos/Module06/data/counts.csv")
fwrite(state_map, "demos/Module06/data/state_map.csv")

