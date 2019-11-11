#
# databases_and_mysql.R
#
library("tidyverse")
library("RMySQL")

# Passengers
pass <- read_csv("..\\..\\data\\passengers.csv")

# Flights
flights <- read_csv("..\\..\\data\\flights.csv")


# Connect to DB and get table list
# Note that you need to make sure that the db, user, passwd match
#   the ones that you used when you setup the database.  If you used
#   my script, they will.
con = dbConnect(MySQL(),dbname='insy6500', user='insy6500',password='insy6500', host = 'localhost')
dbListTables(con)

# manually show the tables
myquery <- "show tables;"
alltables <- as_tibble(dbGetQuery(con, myquery))


#create dataframe with the flights
myquery <-"SELECT * from flight;"
dfFlights <- as_tibble(dbGetQuery(con,myquery))
dfFlights

