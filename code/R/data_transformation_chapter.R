#
# Ch 5 - Data Transformation
# R for Data Science - http://r4ds.had.co.nz/
#
library(tidyverse)
library(nycflights13)

# check out the dataset
?nycflights13::flights
nycflights13::flights
# aliased to flights -- can use either
flights

# Some data on the dataset
class(nycflights13::flights)          # get class
sapply(nycflights13::flights, class)  # get class of all columns
# sapply?
?sapply
str(nycflights13::flights)            # structure
summary(nycflights13::flights)        # summary
colnames(nycflights13::flights)       # columns names
nrow(nycflights13::flights)           # number of rows
ncol(nycflights13::flights)           # number of columns


#
# Using dplyr
#
# Filter ----------------------------------------------------------
# Create a new data frame with the january 1 flights
# note that the outer () mean to print after the assignment
(jan1 <- filter(flights, month == 1, day == 1))

# Seems out of place -- but important.    
# Comparisons -- floating point == can be problematic
sqrt(2)^2 == 2
1/49 * 49 == 1
# use the near() function instead
near(sqrt(2)^2, 2)
near(1/49*49, 1)

# The conditions below are equivalent -- use the format
# that is clearer to you!
(nov_dec <- filter(flights, month == 11 | month == 12))
(nov_dec <- filter(flights, month %in% c(11, 12)))
# don't use "month == 11 | 12" --- why?

# suppose you want to know how many flights from august
# had departure delays of more that 2 hours
# month == 8 and dep_delay > 120 is the condition
(aug_baddies <- filter(flights, month == 8 & dep_delay > 120))

# Note the following version uses two conditions rather than
# a single condition involving an 'and' operator.
(aug_baddies1 <- filter(flights, month == 8, dep_delay > 120))

# Note that filter() excludes NA values in addition to FALSE
# values.  So there is no need to use omit.na() or similar functions.

#
# For comparison, suppose you wanted to these two filter operations
# with standard data frames instead of tibbles and filter()
# Nov+Dec flights
# Note the trailing comma to filter the rows of a DataFrame...
(tmp = flights[flights$month == 11 | flights$month == 12,])
# Let's see what's going on here:
mask = flights$month == 11 | flights$month == 12
# if you just wanted a count of the flights ...
sum(mask)
# August late departures
#
# try counting them first
sum(flights$month == 8 & flights$dep_delay > 120)
aug_baddies2 = flights[flights$month == 8 & flights$dep_delay > 120,]
# oops -- NA values.  Simple masking could count NA values.
# first, get rid of the NA values .. don't forget '?complete.cases' for help
tmp = flights[complete.cases(flights$dep_delay),]
aug_baddies2 = tmp[tmp$month == 8 & tmp$dep_delay > 120,]
? complete.cases
# so, the filter() method on tibbles excludes FALSE and NA values (and is a
# bit easier to read.)


#
# To practice, think of an interesting question and develop the 
# corresponding filter for it ...
#
# flights by tailnum N5CLAA
n5claa <- filter(flights, tailnum =="N5CLAA")

# flights headed for miami during November, December, January, February
beach <- filter(flights, dest == 'MIA' & (month %in% c(1, 2, 11, 12)))

# beach flights that were delayed on arrival for more than 45 minutes
late_beach <- filter(beach, arr_delay > 45)
# or
late_beach <- filter(flights, dest == 'MIA' & (month %in% c(1, 2, 11, 12)) & arr_delay > 45)
# or
late_beach <- filter(flights, dest == 'MIA', (month %in% c(1, 2, 11, 12)), arr_delay > 45)

#
# Arrange ----------------------------------------------------------
# Sort the data -- note that a new tibble is returned, the original is left unchanged
arrange(flights, year, month, day)

(bad_flights <- arrange(flights, desc(dep_delay)))

#
# Select ----------------------------------------------------------
# Select specific columns
select(flights, year, month, day, dep_time)

# helper functions
select(flights, starts_with("arr"))
select(flights, ends_with("time"))
select(flights, contains("dep"))

#
# Mutate ----------------------------------------------------------
# Adding new comlumns

flights_sml <- select(flights, 
  year:day, 
  ends_with("delay"), 
  distance, 
  air_time
)
mutate(flights_sml,
  gain = dep_delay - arr_delay,
  speed = distance / air_time * 60,
  hours = air_time / 60,
  gain_per_hour = gain / hours
)

# transmute if you only want the new columns

transmute(flights,
  gain = dep_delay - arr_delay,
  hours = air_time / 60,
  gain_per_hour = gain / hours
)

#
# Sumarise and Group By ----------------------------------------------------------
summarise(flights, delay=mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
# So, what is the by_day object -- In the environment, it looks just like bad_flights
class(by_day)
class(flights)
?group_by

# to save the daily summaries from above:
daily_summaries <- summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
# sort by badness 
arrange(daily_summaries, desc(delay))


# Group by destination, count the number, sort in descending order
by_dest <- group_by(flights, dest)
s <- summarize(by_dest, 
  num = n(),
  dist = mean(distance, na.rm=TRUE) 
)
(s <- arrange(s, desc(num)))

#
# piping
#
# consider this sample analysis
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
(delay1 <- filter(delay, count > 20, dest != "HNL"))

# It looks like delays increase with distance up to ~750 miles 
# and then decrease. Maybe as flights get longer there's more 
# ability to make up delays in the air?
ggplot(data = delay1, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'

# The 'pipe' allows you to do this type of multi-step process
# without storing the intermediate results;
(delay2 <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL"))


# Suppose that you want to know the popular destinations and thier distances
#
(popular_dests <- flights %>%
  group_by(dest) %>%
  summarize(
    num = n(),
    dist = mean(distance, na.rm=TRUE)
  ) %>%
  filter(num > 5000) %>%
  mutate(tot = num * dist) %>%
  arrange(desc(num)))


# Meal example from the Python section of the class
# Get the current working directory
print(getwd())
# Read the meals data
data <- read.csv("..\\..\\data\\12_meals.csv", stringsAsFactors=FALSE)
meals <- as_tibble(data)


meals <- meals %>%
  mutate(tip_percentage = tip / cost)

summarize(meals, count=n(), 
         avg_tip=mean(tip, na.rm=TRUE),
         avg_cost=mean(cost, na.rm = TRUE),
         med_tp = median(tip_percentage, na.rm = TRUE),
         total_people = sum(party_size, na.rm = TRUE)
         )

# By day: we could filter
meals %>%
  filter(day == "Thu") %>%
  summarize(count=n(), 
            avg_tip=mean(tip, na.rm=TRUE),
            avg_cost=mean(cost, na.rm = TRUE),
            med_tp = median(tip_percentage, na.rm = TRUE),
            total_people = sum(party_size, na.rm = TRUE)
  )

# Or group
(meals_by_day <- meals %>%
  group_by(day) %>%
  summarise (
    count = n(),
    avg_tip = mean(tip, na.rm = TRUE),
    avg_cost = mean(cost, na.rm = TRUE),
    med_tp = median(tip_percentage, na.rm = TRUE),
    total_people = sum(party_size, na.rm = TRUE)
  ))


(meals_by_meal <- meals %>%
  group_by(meal) %>%
  summarise (
    count = n(),
    avg_tip = mean(tip, na.rm = TRUE),
    avg_cost = mean(cost, na.rm = TRUE),
    med_tp = median(tip_percentage, na.rm = TRUE),
    total_people = sum(party_size, na.rm = TRUE)
  ))


(meals_by_payer <- meals %>%
  group_by(payer) %>%
  summarise (
    count = n(),
    avg_tip = mean(tip, na.rm = TRUE),
    avg_cost = mean(cost, na.rm = TRUE),
    med_tp = median(tip_percentage, na.rm = TRUE),
    total_people = sum(party_size, na.rm = TRUE)
  ))
