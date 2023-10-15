# apply, most used for matrices and arrays
mat <- matrix(1:6, nrow = 2)

# row sum
apply(mat, MARGIN = 1, sum)

# col sum
apply(mat, MARGIN = 2, sum)

# sapply, vector version of the apply function
# s standards for simplify, it will return an atomic vector
john <- list(
  name = "John",
  phone_number = c(1, 2, 3),
  email = "john@uw.edu",
  address = list(
    city = "Seattle",
    state = "WA"
  )
)

str(john)

sapply(john, length)

# lapply, used for applying a function to a list
# will return a list
lapply(john, length)
df <- data.frame(a = 1:5, b = 6:10)
lapply(df, mean)
apply(df, MARGIN = 1, mean)

# mapply, is a multi-variable version of sapply
add <- function(a, b) {
  a + b
}

x <- 1:100
y <- 1:100

x + y

mapply(add, x, y)
