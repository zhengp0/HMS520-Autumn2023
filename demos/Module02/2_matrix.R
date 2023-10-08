# create a matrix
m1 <- matrix(1:9, ncol = 3)

m1 <- 1:9
dim(m1) <- c(3, 3)

nrow(m1)
ncol(m1)
dim(m1)

# access elements in a matrix
# access a row
m1[2, ]

# access first two rows
m1[c(1, 2), ]

# access a column
m1[, 1]

# access the 6th elements
m1[6]

# access entire matrix
m1
m1[]

# assign values
m1[] <- 0 # different than m1 <- 0
m1[1, ] <- 1

# special operations, matrix vector product
vec1 <- c(1, 1, 1)
vec2 <- m1 %*% vec1
