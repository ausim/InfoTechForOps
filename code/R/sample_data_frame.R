# ----------------------------------------------------------------------------------
# Use the built-in mtcars dataframe
help(mtcars)
str(mtcars)
head(mtcars, 10)

# element selection
mtcars[5, 3]
mtcars['Duster 360', 'carb']

# Column selection
# slicing ("single bracket")
mtcars[1]
mtcars["hp"]
mtcars[c(1, 3, 5, 7)]
sub1 = mtcars[c("mpg", "wt", "carb")] # ---> Check out the environment

# to extract a column to a vector
# Column name
hp = mtcars$hp # ---> Check out the environment
mean(hp);sd(hp)
# "double brackets"
wt = mtcars[[6]] # ---> environment
mean(wt); sd(wt)

# row slection
# Note the trailing comma when row slicing.  Without it, you're requesting
# a column rather than row slice.
mtcars['Hornet Sportabout',]

mtcars['Hornet Sportabout',1]
rows1 = mtcars['Hornet Sportabout',c(1, 2, 3)]
rows2 = mtcars[c(1, 3, 5, 7),]

# logical indexing (masking)

heavy = mtcars$wt > 4 # ---> environemnt
# Slice the heavy cars
heavy_cars = mtcars[heavy,]

light_cars = mtcars[mtcars$wt < 2,]

# Fromt the bottom of the help page.
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


# ----------------------------------------------------------------------------------
# Sample of reading a dataframe from a file

# Get the current working directory
print(getwd())

# Read the econcomic data
data <- read.csv("..\\..\\data\\10_us_economic_data.csv", stringsAsFactors=FALSE)
head(data,10)
# structure of the data
str(data)

# Get quarterly data
quarterly= data[seq(1,nrow(data), 3 ),]
# quick plot of GDP
plot(quarterly$GDP,type = "o")
