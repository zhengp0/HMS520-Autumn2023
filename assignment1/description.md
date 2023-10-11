# Assignment 1

In this assignment, we will get familiar with basic R syntax.


## Problem 1 (2 pts): create variables
* Create a variable `hometown` that stores the city in which you were born
* Assign your name to the variable `my_name`
* Assign the maximum number of push ups you can do to the variable `num_push_ups`
* Create a boolean variable `need_exercise` to be TRUE if `num_push_ups` is
  lower than 5 else FALSE


## Problem 2 (2 pts): create vectors
* Create an atomic vector `vec1` with values 1, 2, 3, 4, 5
* Use `rep` function creating a vector `vec2` with all elements to be 10 and length to
  be 100
* Repeat vector `vec1` twice into `c(1, 2, 3, 4, 5, 1, 2, 3, 4, 5)` and assign
  it to variable `vec3` (use function `rep`)
* Repeat vector `vec1` twice into `c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)` and assign
  it to variable `vec4` (use function `rep`)
* Use `seq` function create an atomic vector `vec5` with elements 0, 0.01, 0.02, ..., 1


## Problem 3 (2 pts): vector operations
In this problem we will use R built-in data set `rivers`. You can directly type
`rivers` to access it.
* What is the type of `rivers`? (Atomic vector or list?)
* What is the type of the element in `rivers`? (double, integer, logical or string?)
* Log transform `rivers` and assign it a variable called `log_rivers`
* Create an atomic vector called `summary` that contains the length, sum, mean,
  median, min, max and standard deviation of `log_rivers`. And assign proper names for
  each element
* Sort `log_rivers` in the ascending order and re-assign the result to `log_rivers`
* Trim the 10 largest and 10 smallest elements in `log_rivers` and assign it to
  variable `trimmed_log_rivers`
* Create all the summaries of `trimmed_log_rivers` as in `summary` and assign it
  to `trimmed_summary`


## Problem 4 (2 pts): create list
* Create a list `info` with two items `x = c(5, 6, 7, 8)` and `y = c("a", "b", "c", "d")`
* Modify `y` in `info` so that it has values `c(1, 2, 3, 4)`
* Compute the mean of `x` and `y` separately and together, assign them to `mean_x`,
  `mean_y`, `mean_both`
* Add `log_x = log(x)` into the list `info`
* Add `distance = sqrt(x^2 + y^2)` into the list `info`
* Remove `log_x` from `info`


## Problem 5 (2 pts): string vector
* Create a vector `words` with elements "brilliant", "joy", "positivity",
  "strength", "health", "insight"
* Append "is the word of the day!" to each element in `words` and assign it to
  `words_of_the_day` (use function `paste` or `paste0`)
* Create a vector `a_h_words` which are elements in `words` that start with "a"
  through "h" (use function `substring`)
* Create a vector `h_y_words` which are elements in `words` that end with "h"
  trough "y" (use function `nchar` and `substring`)