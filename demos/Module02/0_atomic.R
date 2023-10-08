# please provide three ways to create vector contains 1, 2, ..., 10
vec1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
vec1 <- seq(1, 10)
vec1 <- 1:10

# please access the first and third element
vec1[c(1, 3)]

# please access the values that is greater than 5
vec1[vec1 > 5]

# please assign all even number to 0
vec1[vec1 %% 2 == 0] <- 0

# remove 2nd to 5th elements
vec1[-(2:5)]

# how to combine two vectors
vec2 <- 2:5
c(vec1, vec2)

# create named atomic vectors
vec3 <- c(x = 1, y = 2, z = 3)
vec3 <- 1:3
names(vec3) <- c("x", "y", "z")
vec3["x"]

# how to get number of characters of a string
vec4 <- c("aa", "bb", "cc")
length(vec4)
nchar(vec4)

# type coercion
vec5 <- c(TRUE, 1L)
