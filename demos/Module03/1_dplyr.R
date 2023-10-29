# dplyr exercise
# ===============
library("dplyr")
library("tidyr")

df_population <- read.csv("population.csv", stringsAsFactors = FALSE)
df_death <- read.csv("death.csv", stringsAsFactors = FALSE)
df_hours <- read.csv("hours.csv", stringsAsFactors = FALSE)
df_pay <- read.csv("pay.csv", stringsAsFactors = FALSE)

# 1. subset ---------------------------------------------------------------
# subset rows: filter
df_death_sub <- filter(df_death, location_id == 1)
df_death_sub <- filter(df_death, death > 100)
df_death_sub <- filter(
  df_death,
  death > 100,
  location_id == 1
)

# how to filter out all rows with NAs: if_all
df_death_valid <- filter(
  df_death,
  if_all(everything(), ~ !is.na(.x))
)

# subset cols: select
df_death_copy <- df_death
df_death_copy$random <- "a"
df_death_sub <- select(df_death_copy, c(location_id, sex_id, death))
df_death_sub <- select(df_death_copy, where(is.numeric))
df_death_sub <- select(df_death_copy, ends_with("_id"))

# 2. modify ---------------------------------------------------------------
# order rows: arrange
df_death_mod <- arrange(df_death, death)
df_death_mod <- arrange(df_death, -death)
df_death_mod <- arrange(df_death, location_id, age_group_id, sex_id)

# order cols: relocate
df_death_mod <- relocate(df_death, death, .before = sex_id)

# rename columns: rename, rename_with
df_death_mod <- rename(df_death, death_ihd = death)
df_death_mod <- rename_with(df_death, toupper)

# 3.  add -----------------------------------------------------------------
# add columns: mutate
df_death_add <- mutate(
  df_death,
  log_death = log(death),
  sqrt_death = sqrt(death)
)

# cbind, rbind, bind_rows, bind_cols
df_deaths_extra <- data.frame(
  location_id = 6,
  age_group_id = 1:5,
  sex_id = 1,
  death = 5
)
df_death_add <- rbind(df_death, df_deaths_extra)
df_death_add <- bind_rows(df_death, df_deaths_extra, .id = "new")
df_death_new_col <- data.frame(
  log_death = log(df_death$death)
)
df_death_add <- cbind(df_death, df_death_new_col)

# 4.  join ----------------------------------------------------------------

df_combined <- left_join(
  df_death,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)

# what if there are columns with the same name: suffix
df_death_second <- df_death
df_combined <- left_join(
  df_death,
  df_death_second,
  by = c("location_id", "age_group_id", "sex_id"),
  suffix = c("", "_second")
)

# what if the number of rows are different: left, right, inner
df_death_extra <- data.frame(
  location_id = 6,
  age_group_id = 1:5,
  sex_id = 1,
  death = 5
)
df_death_add <- bind_rows(df_death, df_death_extra)
df_combined <- left_join(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)
df_combined <- right_join(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)
df_combined <- inner_join(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)
df_combined <- full_join(
  df_death_add,
  df_population,
  by = c("location_id", "age_group_id", "sex_id")
)

# what if there are multiple matches
df1 <- data.frame(
  key = c(1, 1, 2, 2),
  value = c(1, 2, 3, 4)
)
df2 <- data.frame(
  key = c(1, 1, 2),
  value = c(5, 6, 7)
)
df_combined <- left_join(
  df1,
  df2,
  by = "key",
  suffix = c("1", "2"),
  relationship = "many-to-many"
)

# what if the names you try to match are different in two data frames
df1 <- data.frame(
  key1 = c(1, 1, 2, 2),
  value1 = c(1, 2, 3, 4)
)
df2 <- data.frame(
  key2 = c(1, 1, 2),
  value2 = c(5, 6, 7)
)
df_combined <- left_join(
  df1,
  df2,
  by = c("key1" = "key2"),
  relationship = "many-to-many"
)

# 5.  group ---------------------------------------------------------------
df_group <- group_by(
  df_death,
  location_id,
  age_group_id
)


# 6.  summarize -----------------------------------------------------------
df_summarize <- summarize(
  df_group,
  mean_death = mean(death)
)

df_summarize <- summarize(
  df_death,
  mean_death = mean(death)
)


# 7.  pipe operator -------------------------------------------------------

# compute average death_rate for location 1, 2, 3, 4 and
# rank data frame by desc order of the death_rate


# 8.  pivot ---------------------------------------------------------------

# pivot long
df_long <- pivot_longer(
  df_hours,
  cols = !project,
  names_to = "employee",
  values_to = "hours"
)

# compute how much do we pay for each employee

# pivot wide
df_wide <- pivot_wider(
  df_long,
  id_cols = project,
  names_from = employee,
  values_from = hours
)

# which religion earn the most?
