# linear regression
# =================
source("demos/Module05/functions.R")

# load data ---------------------------------------------------------------
dt_iris <- fread("iris.csv")

# plot data ---------------------------------------------------------------
plot_data(dt_iris)


# build model -------------------------------------------------------------
# lm
model <- lm(Sepal.Width ~ Sepal.Length, data = dt_iris[test == 0,])
coef(model)
vcov(model)
summary(model)

dt_iris[, sepal_width_fit := predict(model, dt_iris)]

# plot fit ----------------------------------------------------------------
plot_fit(dt_iris)

# summarize fit -----------------------------------------------------------
performance <- get_performance(dt_iris)
