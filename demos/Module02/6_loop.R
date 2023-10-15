# for loop
# loop over elements
vec <- c("a", "b", "c")
for (x in vec) {
  print(x)
}

# loop over indices
for (i in seq_along(vec)) {
  print(vec[i])
}

# next and break
vec2 <- 1:100
s <- 0
for (x in vec2) {
  if (x %% 2 == 1) {
    next
  }
  
  s <- s + x
  
  if (x >= 50) {
    break
  }
}

# while loop
i <- 1
while (i <= length(vec)) {
  print(vec[i])
  i <- i + 1
}

# repeat loop
i <- 1
repeat {
  if (i > length(vec)) {
    break
  }
  
  print(vec[i])
  i <- i + 1
}
