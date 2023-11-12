# datatable exercise
# ==================
library("data.table")

df_population <- fread("population.csv")
df_death <- fread("death.csv")
df_hours <- fread("hours.csv")
df_pay <- fread("pay.csv")

# 1. subset ---------------------------------------------------------------
# subset rows: i expression
df_death_sub <- df_death[location_id == 1,]
df_death_sub <- df_death[death > 100,]
df_death_sub <- df_death[(location_id == 1) & (death > 100)]

# how to filter out all rows with NAs: complete.cases
df_death_sub <- df_death[complete.cases(location_id, sex_id, death)]

# subset cols: j expression, .SD + .SDcols
df_death_sub <- df_death[, c("location_id", "age_group_id")]
df_death_sub <- df_death[, list(location_id, age_group_id)]
df_death_sub <- df_death[, .(location_id, age_group_id)]

selected_cols <- c("location_id", "age_group_id")
df_death_sub <- df_death[, selected_cols, with = FALSE]
df_death_sub <- df_death[, ..selected_cols]

df_death_sub <- df_death[, .SD, .SDcols = selected_cols]


# 2. modify ---------------------------------------------------------------
# order rows: order, i expression
df_death_mod <- df_death[order(location_id),]
df_death_mod <- df_death[order(location_id, -age_group_id),]
df_death_mod <- df_death[order(!death)]

# rename columns: j expression, setnames
df_death_mod <- df_death[, list(death_ihd = death)]
df_death_mod <- copy(df_death)
setnames(df_death_mod, "death", "death_ihd")


# 3.  add -----------------------------------------------------------------
# add columns: j expression, :=
df_death_add <- copy(df_death)
df_death_add[, log_death := log(death)]
df_death_add[, `:=`(log_death = log(death), sqrt_death = sqrt(death))]

# rbind, cbind
df_death_extra_row <- data.table(
  location_id = 6,
  age_group_id = 1:5,
  sex_id = 1,
  death = 5
)
df_death_add <- rbind(df_death, df_death_extra_row)

df_death_extra_col <- data.table(
  row_id = seq_len(nrow(df_death)),
  random = rnorm(nrow(df_death))
)
df_death_add <- cbind(df_death, df_death_extra_col)

# 4.  join ----------------------------------------------------------------
df_combined <- merge(
  df_death,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)

# what if there are columns with the same name: suffix
df_death_second <- copy(df_death)
df_combined <- merge(
  df_death,
  df_death_second,
  by = c("location_id", "age_group_id", "sex_id"),
  suffix = c("", "_copy")
)

# what if the number of rows are different: left, right, inner
df_death_extra <- data.table(
  location_id = 6,
  age_group_id = 1:5,
  sex_id = 1,
  death = 5
)

df_death_add <- rbind(df_death, df_death_extra)

# inner
df_combined <- merge(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)

# left
df_combined <- merge(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id"),
  all.x = TRUE
)

# right
df_combined <- merge(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id"),
  all.y = TRUE
)

# full
df_combined <- merge(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id"),
  all = TRUE
)

# what if there are multiple matches
df1 <- data.table(
  index = c(1, 1, 2, 2),
  value = c(1, 2, 3, 4)
)
df2 <- data.table(
  index = c(1, 1, 2),
  value = c(5, 6, 7)
)

df_combined <- merge(
  df1,
  df2,
  by = "index",
  suffix = c("_1", "_2")
)

# what if the names you try to match are different in two data frames
df1 <- data.table(
  index_1 = c(1, 1, 2, 2),
  value_1 = c(1, 2, 3, 4)
)
df2 <- data.table(
  index_2 = c(1, 1, 2),
  value_2 = c(5, 6, 7)
)

df_combined <- merge(
  df1,
  df2,
  by.x = "index_1",
  by.y = "index_2"
)


# 5.  group and summarize -------------------------------------------------
df_death_group <- df_death[, list(death = sum(death)), by = location_id]
df_death_group <- df_death[, list(death = sum(death)), by = list(location_id, age_group_id)]

# 7.  chaining ------------------------------------------------------------

# compute average death_rate for location 1, 2, 3, 4 and
# rank data frame by desc order of the death_rate

df_combined <- merge(
  df_death,
  df_population,
  by = c("location_id", "age_group_id", "sex_id"),
  all.x = TRUE
)

df_result <- df_combined[
  location_id %in% c(1, 2, 3, 4),
][
  , death_rate := death / population
][
  , list(mean_death_rate = mean(death_rate)), by = "location_id"
][
  order(-mean_death_rate),
]


# 8.  pivot ---------------------------------------------------------------

# pivot long
df_long <- melt(
  df_hours,
  id.vars = "project",
  measure.vars = c("A", "B", "C", "D"),
  variable.name = "employee",
  value.name = "hours"
)

# compute how much do we pay for each employee
df_result <- merge(
  df_long,
  df_pay,
  by = "project",
  all.x = TRUE
)
df_result[, pay := hours * dollar_per_hour]
df_total <- df_result[, list(total = sum(pay)), by = "employee"]

# pivot wide
df_wide <- dcast(
  df_result,
  project ~ employee,
  value.var = "pay"
)

# which religion earn the most?
library("tidyr")

View(relig_income)

dt_relig_income <- as.data.table(relig_income)

col_names <- colnames(dt_relig_income)
col_names <- col_names[!(col_names %in% c("religion", "Don't know/refused"))]
dt_long <- melt(
  dt_relig_income,
  id.vars = "religion",
  measure.vars = col_names,
  variable.name = "income",
  value.name = "count"
)

dt_long[, total := sum(count), by = "religion"]
dt_long[, prop := count / total]

dt_wide <- dcast(
  dt_long,
  religion ~ income,
  value.var = "prop"
)
