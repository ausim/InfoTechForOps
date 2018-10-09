# 
# data_selection.R
#  jeff smith
#
# Note - this script is meant to be used interactively, not in "source" mode.
# ----------------------------------------------------------------------------------
# Use the built-in mtcars dataframe
help(mtcars)

#
# A student question/comment along with the Stack Overflow link sent me down this path ...
# https://stackoverflow.com/questions/17052426/what-is-the-purpose-of-this-trailing-comma-in-r
#

# extract function ([])
# https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/Extract.data.frame
# columns as data frames
mtcars[1:3]
mtcars[,1:3] # leading comma is optional
mtcars[c(1, 2, 3, 6)]
mtcars[,c(1, 2, 3, 6)] # same
mtcars['hp']
mtcars[c('hp', 'mpg')]
mtcars[,c('hp', 'mpg')] # same
# columns as vectors
mtcars[['hp']]
mtcars[[4]]
mtcars[,'hp']
mtcars[,4]
mtcars[1:5, 4]

# rows
mtcars[1:3,]
mtcars[c(1, 2, 3, 6),]

# rows and columns
mtcars[1:3, 1:4]
mtcars[c('Mazda RX4', 'Datsun 710'), c('mpg', 'cyl', 'wt')]
mtcars[1:3,c(4,5)]


# subset function
# Works on rows in dataframes
# https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/subset
subset(mtcars, cyl == 8)
subset(mtcars, hp > 200, select=c(1, 2, 3, 6))
subset(mtcars, wt > 4 & hp > 200)

# note: [ is genrally preferred over subset()
# https://stackoverflow.com/questions/9860090/why-is-better-than-subset
# http://adv-r.had.co.nz/Computing-on-the-language.html
# The following [ statements generate the same as the bove subset() statements
mtcars[mtcars$cyl == 8,]
mtcars[mtcars$hp > 200, c(1, 2, 3, 6)]
mtcars[mtcars$wt > 4 & mtcars$hp > 200,]

mtcars$wt > 4 & mtcars$hp > 200
