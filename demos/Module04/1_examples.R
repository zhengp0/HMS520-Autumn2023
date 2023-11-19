# examples
# ========
library("dplyr")
library("ggplot2")


# scatter plot ------------------------------------------------------------
# useful to see the general trend between dependent and independent variables
# geom_point
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()


# box plot ----------------------------------------------------------------
# inspect variable variation across different groups
# geom_boxplot
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) +
  geom_boxplot()


# bar plot ----------------------------------------------------------------
# direct comparison of certain quantity across different groups
# geom_bar, geom_col
ggplot(iris, aes(x = Species)) +
  geom_bar()

ggplot(iris, aes(x = Species, y = Sepal.Length)) +
  geom_col()


# line plot ---------------------------------------------------------------
# usual is used for prediction
# geom_line
mod <- lm(Sepal.Width ~ Sepal.Length, iris)
print(summary(mod))

iris_pred <- iris %>%
  mutate(sepal_width_fit = predict(mod, iris))

ggplot(iris_pred, aes(x = Sepal.Length)) +
  geom_point(aes(y = Sepal.Width, color = Species)) +
  geom_line(aes(y = sepal_width_fit))


# line with uncertainty ---------------------------------------------------
# it is pretty common to plot the CI of the fit
# geom_ribbon

iris_pred <- as.data.frame(predict(mod, iris, interval = "confidence")) %>%
  rename(
    sepal_width_fit = fit,
    sepal_width_lwr = lwr,
    sepal_width_upr = upr
  ) %>%
  bind_cols(iris)

ggplot(iris_pred, aes(x = Sepal.Length)) +
  geom_point(aes(y = Sepal.Width, color = Species)) +
  geom_line(aes(y = sepal_width_fit)) +
  geom_ribbon(aes(ymin = sepal_width_lwr, ymax = sepal_width_upr), alpha = 0.5)


# -------------------------------------------------------------------------
# ?how can we fit lm for each group
