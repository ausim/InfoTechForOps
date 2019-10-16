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

# --------------------------------------------------------------
# Hello, World!
my_str <- "Hello, World!"
# Note the variable my_str in the Global Environment --->
print(my_str)

# Note the change in the Global Environment --->
my_str <- "blue."

# ---> You can clear the environment using the broom icon
# or using the rm() command

#
# --------------------------------------------------------------
# R Data Types
# logical
cond <- TRUE
print(cond)
cond <- FALSE
class(cond)

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


# --------------------------------------------------------------
# Vectors - single datatype (class)

# Create a vector of type numeric
# note that this single value is a vector (of length 1)
z <- 27.5
z
length(z)

x <- c(12.2, 17.8, 55.4, 35, 68, 55, 23, 97.6)
print(x)
length(x)
print(class(x))
# R indices are 1-based (where Python's are 0-based)
x[1]
z[1]

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
x[3:5]
x[c(2, 3, 6)]
# Note that the negative index doesn't mean start from the end,
# but remove that specific element (or vector).
x[-2]
x[c(-2, -5)]


# --------------------------------------------------------------
# Lists - different datatypes
list1 <- list(c(2,5,3),21.3,sin) #---> check the environment and view the list
print(list1)
class(list1)

print(list1[2])

print(list1[3])

list2 <- list(1, 2, 3, 4 ,5, 6, 7, 9, 10)
print(list2[1])

list2[2]
list1[c(2,3)]

# Why are these two different
x = list(1, 2, 3, 4); x2 = list(1:4)  # ---> check the environment and view the lists

length(x); length(x2)

x3 = list(1:4, 5:8)

# see Tutorialspoint for examples of using element names
# with lists

# --------------------------------------------------------------
# Matrices

# Elements are arranged sequentially by row.
M <- matrix(c(3:14), nrow = 4, byrow = TRUE) # ---> check the environment
print(M)

# Elements are arranged sequentially by column.
N <- matrix(c(3:14), nrow = 4, byrow = FALSE)
print(N)

# Define the column and row names.
rownames = c("row1", "row2", "row3", "row4")
colnames = c("col1", "col2", "col3")

P <- matrix(c(3:14), nrow = 4, byrow = TRUE, dimnames = list(rownames, colnames))
print(P)

# Access the element at 3rd column and 1st row.
print(P[1,3])

# Access the element at 2nd column and 4th row.
print(P[4,2])

# Access only the  2nd row.
print(P[2,])

# Access only the 3rd column.
print(P[,3])

# See Tutorialspoint for examples of accessing elements
# using the row/column names.

# --------------------------------------------------------------
# Arrays
# Similar to matrices, but with more that 2 dimensions -- see
# Tutorialspoint for examples.


# --------------------------------------------------------------
# Factors
# Used for categorical data where there are a fixed number of values to select from
# Create a vector as input.
data <- c("East","West","East","North","North","East","West","West","West","East","North")
print(data)
print(is.factor(data))
class(data)

# Apply the factor function.
factor_data <- factor(data)
print(factor_data)
print(is.factor(factor_data))
class(factor_data)

# --------------------------------------------------------------
# Data Frames - this section focuses on creating data frames and
# using factors.  Accessing elements is illustrated in 
# sample_data_frame.R (and the associated video modules)
#
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

# See sample_data_frame.R for more examples of creating and using
# DataFrames

# --------------------------------------------------------------
# Functions
# define an inspect function
inspect <- function(x, show=FALSE) {
  cat("Class: ", class(x))
  cat("\nType: ", typeof(x))
  cat("\nMode: ", mode(x))
  cat("\nStructure:\n")
  str(x)
  if (show) {
    cat("Object:\n")
    print(x)
  }
}

inspect(27.5, TRUE)
inspect(as.integer(27))
inspect(c(1,2, 3))
inspect(c('a', 'b', 'c'))
inspect(list(1, 2, 3))
inspect(data.frame(V1=c(1, 2, 3, 4)), TRUE)

# see lexical_scoping_example.R

# --------------------------------------------------------------
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


# --------------------------------------------------------------
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
