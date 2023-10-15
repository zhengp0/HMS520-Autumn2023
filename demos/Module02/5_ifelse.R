# if, if else, if else if else
vec <- 1:4
vec <- c(vec, rep(NA, 2))

if (any(is.na(vec))) {
  print("Something is wrong")
} else {
  print("Everthing is alright")
}