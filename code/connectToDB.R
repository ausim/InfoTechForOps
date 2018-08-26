# Required libraries
require(RMySQL)

# Connect to DB and get table list
# Note that you need to make sure that the db, user, passwd match
#   the ones that you used when you setup the database.  If you used
#   my script, they will.
con = dbConnect(MySQL(),dbname='insy6500', user='insy6500',password='insy6500', host = 'localhost')
dbListTables(con)

#create dataframe with the SKU List
myquery <-"SELECT * from skus;"
dfSkus <- dbGetQuery(con,myquery)

head(dfSkus)
