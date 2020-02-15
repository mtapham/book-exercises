# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
source("apikey.R") #go to that file, select all, and hit ctrl-enter


query_params <- list("api-key" = nyt_key)
# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Parasite"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
#   https://developer.nytimes.com/movie_reviews_v2.json
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
base_uri <- "https://api.nytimes.com/svc/movies/v2/"
endpoint <- "reviews/search.json"
uri <- paste0(base_uri, endpoint)

query_params <- list("api-key" = nyt_key, "movie_name" = movie_name)

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
response <- GET(uri, query = query_params)
body <- content(response, "text", encoding = "UTF-8")
data <- fromJSON(body)
# What kind of data structure did this produce? A data frame? A list?
typeof(data) #list

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(data)
names(data$results)
names(data$results$link)

View(data)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(data)
  
# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
most_recent_title <- data$results$display_title[[1]]
most_recent_summary <- data$results$summary_short[[1]]
most_recent_link <- data$results$link$url[[1]]
  
# Create a list of the three pieces of information from above. 
# Print out the list.

list <- list(
  most_recent_title,
  most_recent_summary,
  most_recent_link
  
)
print(list)
