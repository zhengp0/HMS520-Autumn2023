library("data.table")
library("ggplot2")

get_rmse <- function(y, y_fit, na_rm = FALSE) {
  sqrt(mean((y - y_fit)^2, na.rm = na_rm))
}

plot_data <- function(dt_iris) {
  ggplot(dt_iris) +
    geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species))
}

plot_fit <- function(dt_iris) {
  ggplot(dt_iris) +
    geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
    geom_point(data = dt_iris[test == 1,], aes(x = Sepal.Length, y = Sepal.Width), shape = 14) +
    geom_line(aes(x = Sepal.Length, y = sepal_width_fit))
}