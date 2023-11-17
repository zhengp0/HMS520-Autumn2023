# Assignment 4

In this assignment, we will practice create, scatter plot, boxplot and
histogram.

## Prepare data (2 pts)
* Save the `counts` data frame to the current folder `assignment4` (You don't
  have to show the work here, as long as you can load the data from the folder)
* Read data and change column name "mr" to "mortality rate" and "ifr" to
  "infection fatality rate"

## Create scatter plot (3 pts)
Create a scatter plot with xaxis as the `date` and y axis as the `mortality rate`
* use facet wrap to create panels for each state
* specify the number of rows to 10
* use the scale_y_log10 to plot the y axis in log scale
* add title "Mortality Rate" (Hint: check `lab`)
* save the figure as "mr_by_state_date.png" in 10" by 20"

## Create boxplot (3 pts)
Create a box plot with xaxis as different states and y axis as "mortality rate"
* order the x axis so that mr is plotting in a descending order (Hint: check `reorder`)
* change y axis to log scale
* add title "Mortality Rate"
* change x axis label to "state" and y axis label to "mortality rate"
* save the figure as "mr_by_state.png" in 8" by 15"

## Create histogram (2 pts)
Create a histogram for the mean mr and ifr across states
* aggrate the "mortality rate" and the "infection fatality rate" by state
  and assign the result data frame to a variable named `mean_counts`
* reshape `mean_counts` longer, so that each row is defined by one state and
  one rate type (mortality rate or infection fatality rate), assign the result
  data frame to a variable named `mean_counts_long`
* plot `mean_counts_long` using `geom_histogram`
  * with two panels one for mortality rate and other for infection fatality rate
  * scale x axis to log scale
* save the figure as "mr_and_ifr.png" in 8" by 8"