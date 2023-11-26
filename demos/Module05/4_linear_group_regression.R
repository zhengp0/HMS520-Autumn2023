# linear group regression
# =======================
source("demos/Module05/functions.R")

# load data ---------------------------------------------------------------
dt_iris <- fread("iris.csv")

# plot data ---------------------------------------------------------------
plot_data(dt_iris)

# build model -------------------------------------------------------------
# lm with group

dt_group <- split(dt_iris, dt_iris$Species)

models <- lapply(dt_group, function(dt) lm(Sepal.Width ~ Sepal.Length, data = dt))

for (key in names(dt_group)) {
  dt_group[[key]][, sepal_width_fit := predict(models[[key]], dt_group[[key]])]
}

dt_iris <- rbindlist(dt_group)

# plot fit ----------------------------------------------------------------
plot_fit_group(dt_iris, nrow = 3)

# summarize fit -----------------------------------------------------------
performance <- get_performance(dt_iris)
