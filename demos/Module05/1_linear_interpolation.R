# linear interpolation
# ====================
source("demos/Module05/functions.R")

# load data ---------------------------------------------------------------
dt_iris <- fread("iris.csv")


# plot data ---------------------------------------------------------------
plot_data(dt_iris)


# build model -------------------------------------------------------------
# approxfun
dt_train <- dt_iris[test == 0, list(Sepal.Width = mean(Sepal.Width)), by = Sepal.Length]

fun <- with(dt_train, approxfun(x = Sepal.Length, y = Sepal.Width, rule = 2))

dt_iris[, sepal_width_fit := fun(Sepal.Length)]

# plot fit ----------------------------------------------------------------
plot_fit(dt_iris) +
  geom_point(data = dt_train, mapping = aes(x = Sepal.Length, y = Sepal.Width), shape = 12)


# summarize fit -----------------------------------------------------------
performance <- get_performance(dt_iris)
