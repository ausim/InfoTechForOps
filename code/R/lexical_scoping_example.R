#
# Lexical Scoping Example - Clear the environment before experimenting
#
# See https://bookdown.org/rdpeng/rprogdatascience/scoping-rules-of-r.html for more details
#

# Note that a is defined inside the function, y is used,
# but not defined or passed as an arguement, z is defined
# and returned.
my_fun <- function(x) {
  a = "dog"
  z = x+y
  print(ls())
  return(z)
}


# note that the a and Z variables defined in the function
# aren't in the environment.
y = 207
b = my_fun(13)
print(ls())

