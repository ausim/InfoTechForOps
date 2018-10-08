#
# Ch 3 - Visualization
# R for Data Science - http://r4ds.had.co.nz/

library(tidyverse)

# if you don't have it installed, use:
# install.packages("tidyverse")
# and retry the library() function.

# use ? to get help.  Consider a dataset (e.g., mpg), ?mpg gives
# a help page
?mpg

mpg # to show the first 10 rows + information
# What is a tibble?  type 'tibble' and the look for the context menu


# View in grid format and add to the environment
fix(mpg)

# basic scatter plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# help again - note the question mark in front of the function name
?ggplot()
# Slide with Graphing Template

# color the dots by class (a new variable from the data).  Note that
# the color parameter is inside the aesthetic function here
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# use dot size
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))
# Note the warning about using size for a discrete variable.

# use transparency (alpha)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# orange dots - note that the color parameter is outside of
# the aesthetic function here.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color="orange")

# facets
# single variable (the "formula" in R-speak)
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class)

# two variables
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

# Geoms -- Geometric objects
# compare the smooth geom with the point geom earlier -- note
# that the aes() is the same.
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# So, what is this thing?
?geom_smooth

# let's try a generalized linear model (glm)
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy), method="glm")

# divide by drv and use different line types.
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# divide by class and use different line types.
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = class))

# back to drv type with colors
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# now add a dot plot as an overlay
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))


# Statistical transformations - for the previous plots, we
# were plotting the data "as is" with different aesthetics.
# Now let's look and some aggregation/transformations.
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

diamonds

# if you prefer proportions ...
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

#Help!
?geom_bar

# More details
vignette("ggplot2-specs")

# Add some stats - stat_summary() summarizes the y values
# for each unique x value
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

# let's add some color
# outline
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

# fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

# fill on a different variable
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

# diffrent layout, same information
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

# Coordinate Systems
# boxplots
# vertical
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
# horizontal
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

# Coordinate Systems
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()
# flip the axes
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()
