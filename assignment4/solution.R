rm(list = ls())
library("data.table")
library("ggplot2")


# Prepare data ------------------------------------------------------------
# Save the "counts" data in the current folder and load data here
# after load the data, rename column "mr" to "mortality rate" and
# "ifr" to "infection fatality rate"
counts <- fread("./assignment4/counts.csv")
setnames(
    counts,
    c("mr", "ifr"),
    c("mortality rate", "infection fatality rate")
)



# Scatter plot ------------------------------------------------------------
# Create a scatter plot with xaxis as the date and y axis as the mr
# * use facet wrap to create subplot for each state
# * specify the number of rows to 10
# * use the scale_y_log10 to plot the y axis in log scale
# * add title "Mortality Rate"
# * save the figure as "mr_by_state_date.png" in 10" by 20".
ggplot(data = counts) +
    geom_point(aes(date, `mortality rate`)) +
    scale_y_log10() +
    facet_wrap(vars(state), nrow = 10) +
    labs(title = "Mortality Rate")
    
ggsave("./assignment4/mr_by_state_date.png",
       width = 20, height = 10, units = "in")


# Boxplot -----------------------------------------------------------------
# Create a box plot with xaxis as different states and y axis as mr
# * order the x axis so that mr is plotting in a decending order
# * change y axis to log scale
# * add title "Mortality Rate"
# * change x axis label to "state" and y axis label to "mortality rate"
# * save the figure as "mr_by_state.png" in 8" by 15"
ggplot(data = counts) +
    geom_boxplot(aes(reorder(state, -`mortality rate`), `mortality rate`)) +
    scale_y_log10() +
    labs(title = "Mortality Rate", x = "state")

ggsave("./assignment4/mr_by_state.png",
       width = 15, height = 8, units = "in")


# Histogram ---------------------------------------------------------------
# Create a histogram for the mean mr and ifr across states
# * aggrate the "mortality rate" and the "infection fatality rate" by state
#   and assignment the result data frame to a variable named `mean_counts`
# * reshape `mean_counts` longer, so that each row is defined by state and
#   rate type (mortality rate or infection fatality rate), assign the result
#   data frame to a variable named `mean_counts_long`
# * plot `mean_counts_long` using `geom_histogram`
#   * with two panels one for mortality rate and other for infection fatality
#     rate
#   * scale x axis to log scale


mean_counts <- counts[
    ,
    list(
        `mortality rate` = mean(`mortality rate`),
        `infection fatality rate` = mean(`infection fatality rate`)
    ),
    by = "state"
]
mean_counts_long <- melt(
    mean_counts,
    id.vars = "state",
    measure.vars = c("mortality rate", "infection fatality rate"),
    variable.name = "rate_type",
    value.name = "rate"
)

ggplot(data = mean_counts_long) +
    geom_histogram(aes(rate)) +
    scale_x_log10() +
    facet_wrap(vars(rate_type), nrow = 2)

ggsave("./assignment4/mr_and_ifr.png", width = 8, height = 8, units = "in")
