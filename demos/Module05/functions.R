library("data.table")
library("ggplot2")

get_rmse <- function(y, y_fit, na_rm = FALSE) {
  sqrt(mean((y - y_fit)^2, na.rm = na_rm))
}

plot_data <- function(dt_iris) {
  ggplot(dt_iris) +
    geom_point(
      mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species)
    ) +
    geom_point(
      data = dt_iris[test == 1,],
      mapping = aes(x = Sepal.Length, y = Sepal.Width), shape = 14
    )
}

plot_fit <- function(dt_iris) {
  plot_data(dt_iris) +
    geom_line(mapping = aes(x = Sepal.Length, y = sepal_width_fit))
}

plot_fit_group <- function(dt_iris, ...) {
  plot_fit(dt_iris) +
    facet_wrap(vars(Species), ...)
}

get_performance <- function(dt_iris) {
  insample_rmse <- with(dt_iris[test == 0,], get_rmse(Sepal.Width, sepal_width_fit))
  outsample_rmse <- with(dt_iris[test == 1,], get_rmse(Sepal.Width, sepal_width_fit))
  
  print(paste("insample_rmse:", insample_rmse))
  print(paste("outsample_rmse:", outsample_rmse))
  
  invisible(list(insample = insample_rmse, outsample = outsample_rmse))
}