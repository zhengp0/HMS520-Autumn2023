# Assignment 2

In this assignment, we will go through exercises of control flow and functions.


## Problem 1 (2 pts): string indicator
Create a function called `is_string` that takes in a variable and returns `True`
if the variable is a string. We say a variable is a string if it is a character
vector with length 1. Here is the functions signature.
* Arguments
  * `x`: Given variable.
* Returns
  * Returns `TRUE` if `x` is a string and `FALSE` other wise.


## Problem 2 (2 pts): cumsum function
Create a function called `my_cumsum` that mimic the functionality of `cumsum` in
base R using a **for-loop**. For example if our input is `c(1, 2, 3)`, we expect
the output as `c(1, 3, 6)`. Here is the signature of the `my_cumsum` function.
* Arguments
  * `x`: A numeric vector.
* Exceptions
  * Throw error if the vector is not a numeric vector. The error message should
    be `x must be a numeric vector`. (Use `stop` function)
* Returns
  * Return the cumulative sum of the vector


## Problem 3 (3 pts): root mean square error
Create a function called `rmse` that will return the root mean square error of
a given numeric vector.

For example if our input is `c(1, 2, 3)` and our
expected output is `sqrt((1^2 + 2^2 + 3^2)/3)`. Here is the signature of the
`rmse` function.
* Arguments
  * `x`: A numeric vector.
  * `na_rm`: A boolean variable, if true ignore the `NA` values in `x`.
    Optional, default to be `TRUE`.
* Exceptions
  * Throw error if the vector is not a numeric vector. The error message should
    be `x must be a numeric vector`.
* Returns
  * Returns the root mean square error as a scalar value.


## Problem 4 (3 pts): describe difference
Create a function called `describe_difference` that takes in two strings and
compare their lengths. Here is the signature.
* Arguments
  * `x`: Your first string.
  * `y`: Your second string.
* Exceptions
  * Throw error if `x` or `y` is not a string. The error messages should be
    `x must be a string` or `y must be a string`.
* Returns
  * **Silently** return the length difference between the first and second
    string (with sign, length of `x` minus length of `y`), check `invisible()`.
  * If first string is longer, print, `Your first string is longer by N characters`
  * If second string is longer, print, `Your second string is longer by N characters`
  * If they have the same length, print, `Your strings are the same length`
  * Here `N` should be replaced by the absolute value of the length difference