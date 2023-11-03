# Assignment 3

In this assignment, you can use base R, `dplyr` or `data.table` to complete each
question. And we will work with COVID-19 cases and deaths data from [USAFacts](https://usafacts.org/visualizations/coronavirus-covid-19-spread-map/).

For this assignment, we will need deaths, cases and population data.
You can load the data using the base R function `read.csv` or `read_csv` from
`readr` (part of `tidyverse`) or `fread` from `data.table`.
```R
library("readr")
library("dplyr")
library("data.table")


base_url <- "https://static.usafacts.org/public/data/covid-19"
deaths_url <- paste(base_url, "covid_deaths_usafacts.csv", sep = "/")
cases_url <- paste(base_url, "covid_confirmed_usafacts.csv", sep = "/")
population_url <- paste(base_url, "covid_county_population_usafacts.csv",
                        sep = "/")

# options are "read.csv", "read_csv" and "fread"
csv_loader <- fread

deaths <- csv_loader(deaths_url)
cases <- csv_loader(cases_url)
population <- csv_loader(population_url)
```
It is recommended to use either `read_csv` or `fread`.


## Data cleaning (4 pts)
* Clean column names
  * change all column names to lower case
  * and change the date column to the format `"year-month-day"`,
  e.g. `"2021-01-01"` if the date is not already in the this format.
* Collect the date column names of both `deaths` and `cases` data frames, and
  save them into the variables `death_dates` and `case_dates`.
* Aggregate the deaths, cases and population from each county to their state
  using sum, and re-assign them to `deaths`, `cases` and `population`.
* Reshape the `deaths` and `cases` so that each row is from a single state and a
  single date. The date column should be named `"date"` and the count column should
  be named `"deaths"` for `deaths` and `"cases"` for `cases`.
* Merge `deaths`, `cases` and `population` into one data frame called `counts`.
  `deaths` and cases` will be merged by matching `state` and date` and the `population`
  should be merged by matching `state`.


## Data validation and processing (4 pts)
* Order the data by state and date.
* Compute the new deaths and cases for each state, by using the current day's
  count minus the yesterday's count. For the first day in the record we will keep
  the count as the "new" count. For example, if deaths is `c(200, 201, 205, 209)`
  the new deaths should be `c(200, 1, 4, 4)`. Column name for new deaths should be
  `"new_deaths"` and the column name for new cases should be `"new_cases"`.
* You will notice that some of the new deaths or new cases are negative. Replace
  the negative value by 0 and then re-compute the deaths and cases as the cumulative
  sum of the new deaths and new cases.
* Compute the infection fatality rate as the ratio between the deaths and cases.
  The column name should be `ifr`.
* Compute the mortality rate as the ratio between the deaths and population.
  The column name should be `mr`.


## Data analysis and results (2 pts)
* List the top five states with the most deaths, cases.
* List the top five states with the highest infection fatality rate and mortality rate.

(Hint: you can choose to aggregate the values within states and across date using `max`, `sum` or `mean`.
Use any of those you will get the full points.)