## Matrix inverse computation is expensive and thus we cache the inverse
# of a matrix and return the same instance everytime we ask for the inverse
# This programming assignment describes how this can be achieved by 
# encapsulating the original martix and its inverse together


# The function when invoked returns a list which in turn are two functions
# that let the user access the original matrix and its inverse. 
#
# Note that the returned value is immutable and doesn't allow the user 
# to modify the matrix or its inverse. Any new matrix will require re invoking
# the makeCacheMatrix again with the required input matrix. 
#
# The calculation of the inverse is lazy, that is inverse is calculated only 
# upon first invocation of the inverse() function of the cached matrix
#
# Sample invocation for the following is as follows
#
#  cachedMatrix <- makeCacheMatrix(matrix(rnorm(9), nrow=3, ncol=3))
#  cachedMatrix$get()     #Gets the original matrix 
#  cachedMatrix$inverse()    #Gets the cached, inverse of the original matrix
#
# Refer to test_cachematrix.R for some basic test cases around this module
# The implementation assumes that the matrix is always square/ whose inverse can
# be computed

makeCacheMatrix <- function(x = matrix()) {

  mat <<- x
  inv <- NULL 
  
  # Gets the original matrix provided while instantiating the object
  get <- function() {
    mat
  }
  
  # Lazily compute the inverse the first time this method is invoked. 
  # The value is then cached for subsequent invocations
  inverse <- function() {
    if(is.null(inv)) {
      inv <<- solve(mat)
    }
    inv
  }
  
  # Checks if the inverse is present in the cache or not.
  isInCache <- function() {
    !is.null(inv)
  }
  
  list(get=get, inverse=inverse, isInCache=isInCache)
}


## The function simply invokes the inverse function of the passed
#object if makeCacheMatrix passed to this function
cacheSolve <- function(x, ...) {
  x$inverse()
}