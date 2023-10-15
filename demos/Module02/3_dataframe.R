# create a data frame
df <- data.frame(a = 1:3, b = c("a", "b", "c"))

# peek into a dataframe
str(df)

# dimensions, number of rows and number of columns
dim(df)
nrow(df)
ncol(df)

# access column(s) in a data frame
df$a
df[["a"]]
df[c("a", "b")]
df[, "a"]
df[, 1]

# access row(s) in a data frame
df[1:2, ]

# assign values for the data frame
df$a <- 0
df[1:2, "a"] <- 1:2
df$c <- c(4, 5, 6)

# append a row to a data frame
df_new <- rbind(df, list(a = 4, b = "d", c = 7))
df[nrow(df) + 1,] <- list(a = 4, b = "d", c = 7)

# how to remove a column?
df[, -c(1, 2)]
df[, 3]

# how to remove a row?
df[-c(1, 2),]

