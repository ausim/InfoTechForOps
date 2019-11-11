# 
# Models With R - Example 1
# Jeff Smith with 
#  Much code from http://r4ds.had.co.nz/model-basics.html
#
library("tidyverse")
library("modelr")

# Read our simple data set
df <- read_csv("..\\..\\data\\reg_sample.csv")

# Let's have a look
ggplot(data=df) +
  geom_point(aes(x=x, y=y),size=3)


# define a model family using y = w1 + w2*x (intercept/slope line formula)
# model instance - w1, w2
w1 <- 0
w2 <- 150
ggplot(df, aes(x, y)) + 
  geom_abline(aes(intercept = w1, slope = w2)) +
  geom_point(size=3) 



# Generate some random models
num <- 200
models <- tibble(
  w1 = runif(num, -500000, 500000),
  w2 = runif(num, -100, 250)
)

# plot the random models with the data
ggplot(df, aes(x, y)) + 
  geom_abline(aes(intercept = w1, slope = w2), data = models, alpha = 1/4) +
  geom_point(size=3) 



# the model function - takes the model parameters and the x values and
# returns the y values
model1 <- function(w, data) {
  w[1] + data$x * w[2]
}
# sample invocation using the previously
# defined (single values) w1 and w2
model1(c(w1, w2), df)



# distance measure for a model
measure_distance <- function(w, data) {
  diff <- data$y - model1(w, data)
  # RMS
  sqrt(mean(diff ^ 2))
  # RSS
#  sum(diff^2)
}
# sample invocation
measure_distance(c(w1, w2), df)
# Want to use measure_distance to measure the distance
# for each of our models (stored in models)

# I need a 2-parameter function for purrr -- code
# so that the sample dataset used automatically (note
# that df is not a parameter)
sim1_dist <- function(w1, w2) {
  measure_distance(c(w1, w2), df)
}

# sample invocation - same as the measure_distance above.
sim1_dist(w1, w2)

# Use purrr to run the model function for each model
# and store the distance in the tibble
models <- models %>% 
  mutate(dist = purrr::map2_dbl(w1, w2, sim1_dist))

# Plot the "top 10" best models 
ggplot(df, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = w1, slope = w2, colour = -dist), 
    data = filter(models, rank(dist) <= 10)
  )

# Look at the best 10 models in the model parameter
# space (w1~w2)
ggplot(models, aes(w1, w2)) +
  geom_point(data = filter(models, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist))

# Let's generate some more models are in the "good area" of the parameter 
# space and then evalute these models using function
grid <- expand.grid(
  w1 = seq(-300000, 130000, length=25),
  w2 = seq(30, 280, length=25)
) %>%
  mutate(dist = purrr::map2_dbl(w1, w2, sim1_dist))

# view the models with the best ones identified in parameter space
grid %>% 
  ggplot(aes(w1, w2)) +
  geom_point(data = filter(grid, rank(dist) <= 10), size = 4, colour = "red") +
  geom_point(aes(colour = -dist)) 

# plot the best 10 with the data points
ggplot(df, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(
    aes(intercept = w1, slope = w2, colour = -dist), 
    data = filter(grid, rank(dist) <= 10)
  )

# Let's do one more grid refinement
# Go back and look a the parameter space view
grid <- expand.grid(
  w1 = seq(-100000, 50000, length=25),
  w2 = seq(100, 180, length=25)
) %>%
  mutate(dist = purrr::map2_dbl(w1, w2, sim1_dist))
# Go back and look at these in the parameter space
# and with the top 10 models.

# Could continue this process of systematic refinement
# as long as you want, but let's look at some other options.

best <- optim(c(-500000, 0), measure_distance, data = df)
best$par

ggplot(df, aes(x, y)) + 
  geom_point(size = 2, colour = "grey30") + 
  geom_abline(intercept = best$par[1], slope = best$par[2])

# Fit the best linear model using lm()
m <- lm( y ~ x, df)
summary(m)
# plot the scatter and regression
ggplot(data=df) +
  geom_point(aes(x=x, y=y)) + 
  geom_abline(slope=coef(m)[2], intercept=coef(m)[1])

# Some model-related functions - Standard R lm object functions
coef(m)
formula(m)

# Predictions with Modelr
# Create a grid with the independent variables
grid <- df %>%
  data_grid(x)

# add the predictions from model m
grid <- grid %>%
  add_predictions(m)

# plot the points and the line from the predictions
ggplot(df, aes(x)) +
  geom_point(aes(y = y)) +
  geom_line(aes(y = pred), data = grid, colour = "red", size = 1)

# Resituals with Modelr
df <- df %>%
  add_residuals(m)

# frequency of the residuals
ggplot(df, aes(resid)) + 
  geom_freqpoly(binwidth = 50000)

# residuals
ggplot(df, aes(x, resid)) + 
  geom_ref_line(h = 0) +
  geom_point() 

#
# Formulas and Model Families
#
# Create a tibble with a response (y) and 2 variables (x1, x2)
# note the 'r' -- tRibble, not tibble
df <- tribble(
  ~y, ~x1, ~x2,
  4, 2, 5,
  5, 1, 6
)

model_matrix(df, y ~ x1)

model_matrix(df, y ~ x1 + x2)


#
# Diamonds dataset
#
# Poorer quality diamonds appear to be more expensive
ggplot(diamonds, aes(cut, price)) +
  geom_boxplot()



ndf <- diamonds

ndf$size <- cut(ndf$carat, seq(.1, 5))

ggplot(ndf, aes(factor(size), price)) + 
  geom_boxplot()

