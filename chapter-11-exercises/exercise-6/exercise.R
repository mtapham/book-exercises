# Exercise 6: dplyr join operations

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
#install.packages("nycflights13")  # should be done already
library("nycflights13")
library("dplyr")

View(flights)
View(airports)
# Create a dataframe of the average arrival delays for each _destination_, then 
# use `left_join()` to join on the "airports" dataframe, which has the airport
# information
# Which airport had the largest average arrival delay?
avg_arr_delay_by_dest <- flights %>%
  group_by(dest) %>%
  summarise(
    total_delay_month = sum(arr_delay, na.rm = TRUE),
    total_flights_to_dest = n(),
    avg_arr_delay = total_delay_month / total_flights_to_dest
  ) %>%
  mutate(faa = dest) %>% 
  select(faa, avg_arr_delay) %>%
  left_join(airports, by = "faa", copy = FALSE) 
  
  
largest_avg_arr_delay <- avg_dep_delay_by_dest %>%
  filter(avg_arr_delay == max(avg_arr_delay)) %>%
  pull(name) %>%
  print()

# Create a dataframe of the average arrival delay for each _airline_, then use
# `left_join()` to join on the "airlines" dataframe
# Which airline had the smallest average arrival delay?
View(airlines)

avg_arr_delay_by_airline <- flights %>%
  group_by(carrier) %>%
  summarise(
    total_delay_month = sum(arr_delay, na.rm = TRUE),
    total_flights_to_dest = n(),
    avg_arr_delay = total_delay_month / total_flights_to_dest
  ) %>%
  select(carrier, avg_arr_delay) %>%
  left_join(airlines, by = "carrier", copy = FALSE) 


smallest_avg_arr_delay <- avg_arr_delay_by_airline %>%
  filter(avg_arr_delay == min(avg_arr_delay)) %>%
  pull(name) %>%
  print()
