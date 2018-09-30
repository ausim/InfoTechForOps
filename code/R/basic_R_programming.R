# 
# basic_R_programming.R - Examples of basic R programming.
#
# NOTE - this is not to be run as a "single script" -- it's really
# just a sequence of tasks to demonstrate interactively.
#
# Basic R Programming - Stuff/Code from:
#   Samples from  https://www.tutorialspoint.com/r/index.htm
#   IcebreakerR 
#   RTutorial - http://www.r-tutor.com/r-introduction

# -------------------------------------
# Hello, World!
my_str <- "Hello, World!"
# Note the variable my_str in the Global Environment --->
print(my_str)

# Note the change in the Global Environment --->
my_str <- "blue."

# ---> You can clear the environment using the broom icon
# or using the rm() command

#
# -------------------------------------
# R Data Types
# logical
cond <- TRUE
print(cond)
cond <- FALSE

# Numeric
x <- 197.8
x
class(x)

y <- 27
y
class(y)

# Numeric vs integer
z <- 7L
class(z)

z <- as.integer(y)
z
class(z)
z == y
# Unless you want integers for a specific reason, you should 
# use the default (numeric).

# complex
v <- 2+5i
v
class(v)


# Character
a <- "a"
a
class(a)

s <- "This is a string."
s
class(s)

# Raw
v <- charToRaw("Blink")
v
class(v)


# -------------------------------------
# Vectors - single datatype (class)

# Create a vector of type numeric
# note that this single value is a vector (of length 1)
z = 27.5
z
length(z)

x <- c(12.2, 17.8, 55.4, 35, 68, 55, 23, 97.6)
print(x)
length(x)
print(class(x))
# R indices are 1-based (where Python's are 0-based)
x[1]

# Sequences
v <- 5:13
print(v)

print(seq(5, 9, by = 0.4))

# Looks like integers, but defaults to numeric
y <- c(4, 5, 59)
print(y)
print(class(y))

# to specify integer ...
y <- c(as.integer(4), as.integer(5), as.integer(59))
# or
#y <- c(4L, 5L, 59L)
print(y)
print(class(y))
# Unless you want integers for a specific reason, you should 
# use the default (numeric).

apple <- c('red','green',"yellow")
print(apple)
# Get the class of the vector.
print(class(apple))

# Selecting elements and slicing
x[4]
x[-2]
x[c(2, 3, 6)]


# -------------------------------------
# Lists - different datatypes
list1 <- list(c(2,5,3),21.3,sin)
print(list1)
class(list1)

class(list1[2])
print(list1[2])

class(list1[3])
print(list1[3])

list2 <- list(1, 2, 3, 4 ,5, 6, 7, 9, 10)
class(list2[1])
print(list2[1])

list2[2]
list1[c(2,3)]

# Why are these two different
x = list(1, 2, 3, 4); x2 = list(1:4)


# -------------------------------------
# Matrices

# -------------------------------------
# Arrays

# -------------------------------------
# Factors
# Create a vector as input.
data <- c("East","West","East","North","North","East","West","West","West","East","North")
print(data)
print(is.factor(data))

# Apply the factor function.
factor_data <- factor(data)
print(factor_data)
print(is.factor(factor_data))


# -------------------------------------
# Data Frames
# Create the data frame.
emp.data <- data.frame(
  emp_id = c (1:5), 
  emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
  salary = c(623.3,515.2,611.0,729.0,843.25), 
  start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
                         "2015-03-27")),
  stringsAsFactors = FALSE
)
# Print the data frame.			
print(emp.data) 

# using factors with data frames
# Create the vectors for data frame.
height <- c(132,151,162,139,166,147,122)
weight <- c(48,49,66,53,67,52,40)
gender <- c("male","male","female","female","male","female","male")
# Create the data frame.
input_data <- data.frame(height,weight,gender)
print(input_data)
# Test if the gender column is a factor.
print(is.factor(input_data$gender))
# Print the gender column so see the levels.
print(input_data$gender)


# -------------------------------------
# Selection -- if statemenets
x <- 400
if (x < 200) {
  print("Yep")
} else {
  print("Nope")
}

x <- c("what","is","truth")
if("Truth" %in% x) {
  print("Truth is found")
} else {
  print("Truth is not found")
}


# -------------------------------------
# Repetition -- Loops
# for loop
v <- LETTERS[1:4]
for ( i in v) {
  print(i)
}

# while loop
v <- c("Hello","while loop")
cnt <- 2
while (cnt < 7) {
  print(v)
  cnt = cnt + 1
}

# repeat loop
v <- c("Hello","loop")
cnt <- 2
repeat {
  print(v)
  cnt <- cnt+1
  
  if(cnt > 5) {
    break
  }
}


# built-in functions
# Create a sequence of numbers from 32 to 44.
print(seq(32,44))

# Find mean of numbers from 25 to 82.
print(mean(25:82))
# find std dev of numbers from 25 to 82.
print(sd(25:82))

# Find sum of numbers frm 41 to 68.
print(sum(41:68))

# Note that 41:68 and seq(41, 68) are equivalent



# From Icebreaker R
hi.there <- function() {
  cat("Hello World!\n")
}

# get current working directoy
getwd()

# set working directory
setwd('c:\\tmp')
setwd('c:/Users/smitjef/OneDrive - Auburn University/Courses/INSY 6500/code/R')

# structure - gives the structure of an object
str(x)
str(bundles)
