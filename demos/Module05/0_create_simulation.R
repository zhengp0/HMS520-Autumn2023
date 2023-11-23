# create simulation
# =================
library("data.table")

# create training and testing split ---------------------------------------
seed <- 123L
set.seed(seed)

dt_iris <- as.data.table(iris)

n <- nrow(dt_iris)
n_test <- as.integer(0.1 * n)
i_test <- sample.int(n, size = n_test)
dt_iris[, test := 0]
dt_iris[i_test, test := 1]

fwrite(dt_iris, "iris.csv")
