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
  geom_vline(xintercept=mean(aure$Price), color="red")

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
# Looks like a significan outlier ....
filter(aure, DaysOnMarket > 2000)
ggplot(data = filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)) +
  geom_histogram(mapping = aes(x = DaysOnMarket)) +
  geom_vline(xintercept=mean(filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)$DaysOnMarket), color="red") +
  geom_vline(xintercept=median(filter(aure, DaysOnMarket > 0, DaysOnMarket < 1000)$DaysOnMarket), color="blue")


#
# Covariation samples ----------------------------------------
#
# Scatter plot of price ~ sqft, colored by # bedrooms
# Scatter plot
ggplot(data=aure) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  scale_color_gradient(low="blue", high="red")
# filter out the observations with 0 SqFt
ggplot(data=filter(aure, SqFt>0)) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) +
  scale_color_gradient(low="blue", high="red")

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

aure %>% 
  count(NBed, NBath) %>%  
  ggplot(mapping = aes(x = NBed, y = NBath)) +
  geom_tile(mapping = aes(fill = n))

#
# Aggregation/Grouping ------------------------------------------------
#
# summarize the data
summarise(aure, num=n(), dollars=sum(Price), dom=mean(DaysOnMarket), dom1=median(DaysOnMarket))

# Transactions by firm
ggplot(data = aure) +
  geom_bar(mapping = aes(x=Firm))

# Agency Production
by_agency <- group_by(aure, Firm)
agency_prodn <- summarize(by_agency, 
                          num=n(),
                          dollars = sum(Price), 
                          dom=mean(DaysOnMarket), 
                          dom1=median(DaysOnMarket)) %>% 
  arrange(desc(num))

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


# Regression
df <- filter(aure, SqFt > 0)
# regression
m <- lm( Price ~ SqFt, df)
summary(m)
# plot the scatter and regression
ggplot(data=aure) +
  geom_point(aes(x=SqFt, y=Price,color=Bedrooms)) + 
  scale_color_gradient(low="blue", high="red") +
  geom_abline(slope=coef(m)[2], intercept=coef(m)[1])

# multiple
m2 <- lm( Price ~ SqFt + Bedrooms + Baths, data = df)
summary(m2)
