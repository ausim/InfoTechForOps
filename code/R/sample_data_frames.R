# 
# sample_data_frames.R
#  jeff smith
#
# Note - this script is meant to be used interactively, not in "source" mode.
# Video Modules - http://jsmith.co/node/258
# ----------------------------------------------------------------------------------
# Use the built-in mtcars dataframe
help(mtcars)

# Some standard infomation functions.
# from http://r-statistics.co/R-Tutorial.html
# Note that many of these functions take general
# R objects as arguements -- not only DataFrames.
class(mtcars)  # get class
sapply(mtcars, class)  # get class of all columns
str(mtcars)  # structure
summary(mtcars)  # summary of mtcars
head(mtcars)  # view the first 6 obs
fix(mtcars)  # view spreadsheet like grid - and adds to the environment
rownames(mtcars)  # row names
colnames(mtcars)  # columns names
nrow(mtcars)  # number of rows
ncol(mtcars)  # number of columns

# Element selection - the next two are equivalent
mtcars[5, 3]
mtcars['Hornet Sportabout', 'disp']

# Column selection
# slicing ("single bracket") - creates a new data frame
mtcars[1]
mtcars["hp"]
mtcars[c(1, 3, 5, 7)]
sub1 <- mtcars[c("mpg", "wt", "carb")] # ---> Check out the environment

# to extract a column to a vector
# Column name
hp <- mtcars$hp # ---> Check out the environment
mean(hp);sd(hp)
# "double brackets"
wt <- mtcars[[6]] # ---> environment
mean(wt); sd(wt)

# row slection
# Note the trailing comma when row slicing.  Without it, you're requesting
# a column rather than row slice.
mtcars['Hornet Sportabout',]

rows1 <- mtcars['Hornet Sportabout',c(1, 2, 3)]
rows2 <- mtcars[c(1, 3, 5, 7),]

# logical indexing (masking)
heavy <- mtcars$wt > 4 # ---> environemnt
# Slice the heavy cars
heavy_cars <- mtcars[heavy,]
# apply the condition directly
light_cars <- mtcars[mtcars$wt < 2,]

# 6-cylinder cars that get better than 20 mpg
six_twenty <- mtcars[mtcars$mpg > 20 & mtcars$cyl == 6,]

# more than 250 HP - don't forget that trailing comma!
big_boys <- mtcars[mtcars$hp > 250,]

# From the bottom of the help page.
# Not sure I can interpret, but it looks cool.
require(graphics)
pairs(mtcars, main = "mtcars data", gap = 1/4)
coplot(mpg ~ disp | as.factor(cyl), data = mtcars,
       panel = panel.smooth, rows = 1)
## possibly more meaningful, e.g., for summary() or bivariate plots:
mtcars2 <- within(mtcars, {
  vs <- factor(vs, labels = c("V", "S"))
  am <- factor(am, labels = c("automatic", "manual"))
  cyl  <- ordered(cyl)
  gear <- ordered(gear)
  carb <- ordered(carb)
})
summary(mtcars2)
summary(mtcars)

# ----------------------------------------------------------------------------------
# Sample of reading a dataframe from a file

# Get the current working directory
print(getwd())

# Read the econcomic data
data <- read.csv("..\\..\\data\\10_us_economic_data.csv", stringsAsFactors=FALSE)
head(data,10)
# structure of the data
str(data)
summary(data)

# plot of Unemployment rate
# types: l, p, b, o
plot(data$UnemploymentRate, type = 'l')
# jobs added
plot(data$JobsAdded, type = 'o')
# GDP
plot(data$GDP, type = 'o')
# gaps -- missing data.

# Get quarterly data - every 3 months
quarterly <- data[seq(1,nrow(data), 3 ),]
# quick plot of GDP
plot(quarterly$GDP,type = "o")

# Months with more than 300(thousand) jobs created
mask <- data$JobsAdded > 300
big_jobs_added <- data[mask,]

# Months with > 18000 GDP
mask <- data$GDP > 18000
big_gdp <- data[mask,] # ---> Argh - Check the dataframe.  All those NAs
# use na.omit() to get rid of them (different than previously where
# we used a 3-month step).  But first, check out na.omit()
?na.omit
good <- na.omit(data, cols="GDP")
big_gdp <- good[good$GDP > 18000,]


# ----------------------------------------------------------------------------------
# Larger dataset

# Want the flights data, but don't want a tibble (yet).
# Ignore the next 5 lines and start with the data frame dflights.
library(tidyverse)
library(nycflights13)
nycflights13::flights
dflights <- nycflights13::flights %>%
  as.data.frame()
# -------------------------
# Ok -- we have it now.  Check the structure
str(dflights)

# How many flights in December?
sum(dflights$month == 12)

# How many Delta flights in December?
# Carriers
carriers <-unique(dflights[,'carrier'])
# carrier == 'DL' & month == 12
mask <- dflights$carrier == 'DL' & dflights$month == 12
sum(mask)
# Let's grab them -- don't forget that trailing comma!
dl_dec <- dflights[mask,]

# Get the to-Atlanta flights from that set
atl <- dl_dec[dl_dec$dest == 'ATL',]

# how many total flights are going to ATL (not just DL)?
mask <- dflights$month == 12 & dflights$dest == 'ATL'
sum(mask)

# total departure delays on these flights
sum(atl$dep_delay)
# ouch -- missing data
# Dump the NAs and sum the departure delay for the rest
b <- na.omit(atl, cols='dep_delay')
sum(b$dep_delay)
# or skip the intermediate data frame b
sum(na.omit(atl, cols='dep_delay')$dep_delay)

