#
# Exploratory Data Analysis
# Jeff Smith with
#    material from http://r4ds.had.co.nz/exploratory-data-analysis.html
#
library("tidyverse")

# Read in and add some new variables
aure <- read_csv("..\\..\\data\\au_real_estate_2017_anon.csv")

# structure of the data
aure <- aure %>%
  mutate(
    Baths = BathsFull + BathsHalf,
    PType = substring(MLSID, 1, 1),
    NBed  = as.character(Bedrooms),
    NBath = as.character(Baths)
  )
# PTypes: C - Condo; H - ?; N - New Construction; O - First right of refusal
#   P - Proposed; R - Residential; S - ?; T - Townhome
# Shouldn't be any 'O' or 'P' values -- someone didn't update.

#
# Variation Samples -------------------------------------------
#
# Property Price histogram
ggplot(data = aure) +
  geom_histogram(mapping = aes(x = Price), binwidth = 50000) +
  geom_vline(xintercept=mean(aure$Price), color="red") + 
  geom_vline(xintercept=median(aure$Price), color="blue") 
  
  
ggplot(data = aure) +
  geom_freqpoly(mapping = aes(x = Price), binwidth = 50000, size=1.5, color="orange")

# Property type bar chart
ggplot(data = aure) +
  geom_bar(mapping = aes(x=PType))

# Property sizes histogram
ggplot(data = aure) +
  geom_histogram(mapping = aes(x = SqFt)) +
  geom_vline(xintercept=mean(aure$SqFt), color="red")
# Yikes -- a 0-sqft property?  Let's check it out....
filter(aure, SqFt == 0)
# Make a mental note that these data exist in our dataset.

# Number of bedrooms/bathrooms
ggplot(data = aure) +
  geom_bar(mapping = aes(x=Bedrooms,fill=NBath))
# Note that we need the categorial variable for the fill aesthetic.  
# Try using the numerical value instead ...
ggplot(data = aure) +
  geom_bar(mapping = aes(x=Bedrooms,fill=Baths))

# How long do properties stay on the market?
ggplot(data = aure) +
  geom_histogram(mapping = aes(x = DaysOnMarket)) +
  geom_vline(xintercept=mean(aure$DaysOnMarket), color="red")
# Hmmm ... some negative values?
filter(aure, DaysOnMarket < 0)
# Yep -- mental note.
# Looks like a significant outlier ....
# may need in install the pillar package here ...
filter(aure, DaysOnMarket > 2000)

ggplot(data = filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)) +
  geom_histogram(mapping = aes(x = DaysOnMarket)) +
  geom_vline(xintercept=mean(filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)$DaysOnMarket), color="red") +
  geom_vline(xintercept=median(filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)$DaysOnMarket), color="blue")
# still looks like a couple of outliners  -- what about limiting to 1 year on the market?
ggplot(data = filter(aure, DaysOnMarket > 0, DaysOnMarket < 365)) +
  geom_histogram(mapping = aes(x = DaysOnMarket)) +
  geom_vline(xintercept=mean(filter(aure, DaysOnMarket > 0, DaysOnMarket < 365)$DaysOnMarket), color="red") +
  geom_vline(xintercept=median(filter(aure, DaysOnMarket > 0, DaysOnMarket < 365)$DaysOnMarket), color="blue")



#
# Covariation samples ----------------------------------------
#
# Price by bedrooms
# per https://stackoverflow.com/questions/11766856/normalizing-y-axis-in-histograms-in-r-ggplot-to-proportion
# to get the proportions
ggplot(data = filter(aure, Bedrooms < 5)) +
  geom_histogram(mapping = aes(x = Price, y=..count../sum(..count..)), binwidth = 50000) +
  geom_vline(xintercept=median(filter(aure, Bedrooms < 5)$Price), color="red") +
  facet_wrap(~NBed)
# Price by bedrooms and bathrooms
ggplot(data = filter(aure, Bedrooms < 5, Baths < 5)) +
  geom_histogram(mapping = aes(x = Price, y=..count../sum(..count..), fill=NBed), binwidth = 50000) +
  geom_vline(xintercept=median(filter(aure, Bedrooms < 5)$Price), color="red") +
  facet_grid(NBath~NBed)


# Scatter plot of price ~ sqft, colored by # bedrooms
# Scatter plot
ggplot(data=aure) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  scale_color_gradient(low="blue", high="red")
# filter out the observations with 0 SqFt
ggplot(data=filter(aure, SqFt>0)) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  scale_color_gradient(low="blue", high="red")
# Under 4000 sqft
ggplot(data=filter(aure, SqFt>0, SqFt < 4000)) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  scale_color_gradient(low="blue", high="red")
# By Number of bedrooms
ggplot(data=filter(aure, SqFt>0)) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  facet_wrap(~NBed)
# By Number of bedrooms and bathrooms
ggplot(data=filter(aure, SqFt>0, Bedrooms < 6, Baths < 6)) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  facet_grid(NBath ~ NBed)

# price ~ bedrooms
ggplot(data=aure) +
  geom_point(aes(x=Bedrooms, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")
# box plot using the categorical variable
ggplot(data = aure, mapping = aes(x = NBed, y = Price)) + 
  geom_boxplot()
# same plot using the grouping function with the continuous variable
ggplot(data = aure, mapping = aes(x = Bedrooms, y = Price)) + 
  geom_boxplot(mapping = aes(group = cut_width(Bedrooms,1)))

# price ~ baths (half + full)
ggplot(data=aure) +
  geom_point(aes(x=Baths, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")

# price ~ Days on Market
ggplot(data=aure) +
  geom_point(aes(x=DaysOnMarket, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")

# Get rid of the clear outlier and negative values
ggplot(data=filter(aure, DaysOnMarket > 0, DaysOnMarket < 2000)) +
  geom_point(aes(x=DaysOnMarket, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")

# Focus on those that spent less than a year on the market
ggplot(data=filter(aure, DaysOnMarket > 0, DaysOnMarket < 365)) +
  geom_point(aes(x=DaysOnMarket, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")

# Focus on those that spent less than 90 days on market
ggplot(data=filter(aure, DaysOnMarket > 0, DaysOnMarket < 90)) +
  geom_point(aes(x=DaysOnMarket, y=Price,color=SqFt)) +
  scale_color_gradient(low="blue", high="red")

# baths vs bedrooms
ggplot(data = aure) +
  geom_count(mapping = aes(x = NBed, y = NBath))
# or a color tile version - Note the use of the pipe with
# ggplot.  It's limited in that you still need to use the
# '+ notation' to add components.
aure %>% 
  count(NBed, NBath) %>%  
  ggplot(mapping = aes(x = NBed, y = NBath)) +
  geom_tile(mapping = aes(fill = n))

#
# Aggregation/Grouping ------------------------------------------------
#
# summarize the data
summarise(aure, num=n(), dollars=sum(Price), dom=mean(DaysOnMarket), dom1=median(DaysOnMarket))

# By Subdivision- group and summarize 
subdivision <- aure %>%
  group_by(Subdivision) %>%
  summarize(
    num = n(),
    avg_price = mean(Price),
    med_price = median(Price),
    avg_sqft = mean(SqFt),
    med_sqft = median(SqFt),
    avg_dom = mean(DaysOnMarket), 
    med_dom = median(DaysOnMarket)
  ) %>%
  arrange(desc(num))

# which subdivsions sell?
ggplot(data = subdivision) +
  geom_col(mapping = aes(x=Subdivision, y=num))
# filter down
ggplot(data = filter(subdivision, num > 20)) +
  geom_col(mapping = aes(x=Subdivision, y=num))
# Median price by subdivision?
ggplot(data = subdivision) +
  geom_col(mapping = aes(x=Subdivision, y=med_price))
ggplot(data = filter(subdivision, num > 20)) +
  geom_col(mapping = aes(x=Subdivision, y=med_price))


# Transactions by firm
# Agency Production - Note that I created the
# new tibble here rather than using the pipe as above.
by_agency <- group_by(aure, Firm)
agency_prodn <- summarize(by_agency, 
                          num=n(),
                          dollars = sum(Price), 
                          dom=mean(DaysOnMarket), 
                          dom1=median(DaysOnMarket)) %>% 
  arrange(desc(num))

# Transactions by firm
ggplot(data = agency_prodn) +
  geom_col(mapping = aes(x=Firm, y=num))

# Now we can filter by the summary values
ggplot(data = filter(agency_prodn, num > 50)) +
  geom_col(mapping = aes(x=Firm, y=num))

# Median days-on-market.
ggplot(data = filter(agency_prodn, num > 50)) +
  geom_col(mapping = aes(x=Firm, y=dom1))


# Agent Production
by_agent <- group_by(aure, Agent)
agent_prodn <- summarize(by_agent, 
                         num=n(), 
                         dollars = sum(Price), 
                         dom=mean(DaysOnMarket), 
                         dom1=median(DaysOnMarket)) %>% 
  arrange(desc(num))

# Agent production (dollars) with mean and median
ggplot(data = agent_prodn) +
  geom_histogram(mapping = aes(x = dollars), binwidth = 500000) +
  geom_vline(xintercept=median(agent_prodn$dollars), color="red") +
  geom_vline(xintercept=mean(agent_prodn$dollars), color="blue")

# remove the two clear outliers ... 
ggplot(data = filter(agent_prodn, dollars < 2000000)) +
  geom_histogram(mapping = aes(x = dollars), binwidth = 75000) +
  geom_vline(xintercept=median(agent_prodn$dollars), color="red") +
  geom_vline(xintercept=mean(agent_prodn$dollars), color="blue")


# Firm (Agency) production
# Agent production (dollars) with mean and median
ggplot(data = agency_prodn) +
  geom_histogram(mapping = aes(x = dollars), binwidth = 500000) +
  geom_vline(xintercept=median(agency_prodn$dollars), color="red") +
  geom_vline(xintercept=mean(agency_prodn$dollars), color="blue")

# remove the two clear outliers ... 
ggplot(data = filter(agency_prodn, dollars < 5000000)) +
  geom_histogram(mapping = aes(x = dollars), binwidth = 75000) +
  geom_vline(xintercept=median(agency_prodn$dollars), color="red") +
  geom_vline(xintercept=mean(agency_prodn$dollars), color="blue")


#
# Meals Tip Data
#
# Read the meals data
data <- read.csv("..\\..\\data\\12_meals.csv", stringsAsFactors=FALSE)
meals <- as_tibble(data)
meals <- meals %>%
  mutate(tip_percentage = tip / cost)

# Meals by Day
ggplot(data = meals) +
  geom_bar(mapping = aes(x=day))

# Meals by Meal
ggplot(data = meals) +
  geom_bar(mapping = aes(x=meal))

# Cost
ggplot(data = meals) +
  geom_histogram(mapping = aes(x=cost))

# Cost
ggplot(data = meals) +
  geom_histogram(mapping = aes(x=cost)) +
  facet_wrap(~meal)


# Tip Percentage
ggplot(data = meals) +
  geom_histogram(mapping = aes(x=tip_percentage, y=..count../sum(..count..)), bins=10)

# By meal
ggplot(data = meals) +
  geom_histogram(mapping = aes(x=tip_percentage, y=..count../sum(..count..)), bins=10) +
  facet_wrap(~meal)



