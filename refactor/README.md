# Code Refactor

In this exercise, we will work with script `dm_sequelae_split.R` from real
application. We will dissect the "dos" and "don'ts", and improve the code in

* Readability
* Extentability

There are the most important aspects when designing a script. Readability will
help us maintain and repurpose the code. And extentability will allow us to
adpat the new tasks fast and reliably.

## Steps

* Understand the function of the code
* Identify the issues of the code
  * what makes it hard to read?
  * what makes it error-prune?
  * what makes it hard to test?
  * what makes it hard to extend?
* Focus on each issue think about the solution

## Common issues

In this exercise, we will target at common issues, including

* Script multiple responsibilities
* Inconsistent naming of variables and functions
* Inconsistent coding style
* Hard-coded global values
* Code repetition

## Acknowledgement

The script `dm_sequelae_split.R` is provided by Liane Ong's team from IHME.
Thanks very much for the generosity of helping us improve our coding skills!