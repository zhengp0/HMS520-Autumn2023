# ggplot2
# =======
library("ggplot2")


# data and aesthetic mappings ---------------------------------------------
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()


# geometric objects --------------------------------------------------------
# https://ggplot2.tidyverse.org/reference/
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  geom_line()


# scale: scale_y_log10 ----------------------------------------------------
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  scale_y_log10()


# transformation: coord_trans ---------------------------------------------
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  coord_trans(y = "log10")


# polar coordinate: coord_polar -------------------------------------------
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  coord_polar(theta = "x")


# facet -------------------------------------------------------------------
# facet_wrap, facet_grid
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  facet_wrap(vars(Species), nrow = 3)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  facet_grid(vars(Species), vars(Petal.Length))

# save figures: ggsave ----------------------------------------------------
fig <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

ggsave("graph.png", plot = fig)
