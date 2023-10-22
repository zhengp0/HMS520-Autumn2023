# call a function
a <- "bakka"
substring(a, first = 1, last = 2)
args <- list(
  a, first = 1, last = 2
)

# define a function
add_2 <- function(x) {
  x + 2
}
add_2(10)

# default values
add_2()
add_2 <- function(x = 0) {
  x + 2
}
add_2()

# return values
add_2 <- function(x = 0) {
  if (!is.numeric(x)) {
    print("`x` is not numeric, reset `x` to 0")
    return(2)
  }
  x + 2
}
add_2("a")
add_2()

# missing values
plot_x_y <- function(x, y) {
  if (missing(y)) {
    y <- x
    x <- seq_along(y)
  }
  plot(x, y)
}
plot_x_y(sin(seq(0, 2*pi, length.out = 101L)))

# ellipses, ...
to_list <- function(a = 1, b = 2, ...) {
  print(paste0("a = ", a))
  print(paste0("b = ", b))
  list(...)
}

extra <- to_list(d = 5, e = 6)

# file_path exercise
# combine all the arguments together
# make sure the path satisfy the standard

file_path <- function(...) {
  fsep <- .Platform$file.sep
  path <- paste(..., sep = fsep)
  path <- gsub(paste0(fsep, "{2,}"), fsep, path)
  path
}

# output: "a/b"
file_path("a", "b")
# output: "a/b"
file_path("a/", "/b")

# dependency injection
file_path <- function(..., fsep = .Platform$file.sep) {
  path <- paste(..., sep = fsep)
  path <- gsub(paste0(fsep, "{2,}"), fsep, path)
  path
}

# output: "a/b"
file_path("a", "b")
# output: "a/b"
file_path("a/", "/b")
# output: "apb"
file_path("a", "b", fsep = "p")

# documentation
# install.packages("roxygen2")

#' Generate file path
#'
#' @param ... file path components
#' @param fsep file path separator
#'
#' @return
#' @export
#'
#' @examples
file_path <- function(..., fsep = .Platform$file.sep) {
  path <- paste(..., sep = fsep)
  path <- gsub(paste0(fsep, "{2,}"), fsep, path)
  path
}
