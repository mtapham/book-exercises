# Exercise 5: dplyr grouped operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`

#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

# What was the average departure delay in each month?
# Save this as a data frame `dep_delay_by_month`
# Hint: you'll have to perform a grouping operation then summarizing your data
avg_dep_delay_by_month <- flights %>%
  group_by(month) %>%
  summarise(
    num_flights_month = n(),
    total_delay = sum(dep_delay, na.rm = TRUE),
    avg_delay = total_delay / num_flights_month
  ) %>%
  arrange(-avg_delay) %>%
  select(month, avg_delay) %>%
  print()

# Which month had the greatest average departure delay?
find_greatest_avg_dep_delay <- avg_dep_delay_by_month %>%
  filter(avg_delay == max(avg_delay)) %>%
  pull(month) %>%
  print()

# If your above data frame contains just two columns (e.g., "month", and "delay"
# in that order), you can create a scatterplot by passing that data frame to the
# `plot()` function
plot(avg_dep_delay_by_month)

# To which destinations were the average arrival delays the highest?
# Hint: you'll have to perform a grouping operation then summarize your data
# You can use the `head()` function to view just the first few rows
avg_dep_delay_by_dest <- flights %>%
  group_by(dest) %>%
  summarise(
    total_delay_month = sum(arr_delay, na.rm = TRUE),
    total_flights_to_dest = n(),
    avg_delay = total_delay_month / total_flights_to_dest
  ) %>%
  arrange(-avg_delay) %>%
  select(dest, avg_delay) %>%
  head(5) %>%
  print()
  
# You can look up these airports in the `airports` data frame!
nycflights13::airports
View(airports)

# Which city was flown to with the highest average speed?
highest_avg_speed_cty <- flights %>%
  group_by(dest) %>%
  summarise(
    total_dist = sum(distance, na.rm = TRUE),
    total_time = sum(air_time, na.rm = TRUE),
    avg_speed = total_dist / total_time,
  ) %>%
  filter(avg_speed == max(avg_speed)) %>%
  pull(dest) %>%
  print()