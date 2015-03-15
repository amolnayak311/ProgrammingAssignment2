#The Test class for cachematrix.R
 
# Step 1, call setwd() and set the working directory where the cachematrix.R 
# is found
# setwd(...)

source("cachematrix.R")

#Step 2 create an instance for the given square matrix
set.seed(1)
input_matrix <- matrix(rnorm(9), nrow=3, ncol=3)
expected_inverse <- solve(input_matrix)
cachedMatrix <- makeCacheMatrix(input_matrix)


#########           Tests           ########

#Case 1, see if the matrix we get is same as the input
check <- cachedMatrix$get() == input_matrix
stopifnot(sum(check)==9)

#Case 2, the value will not be in cache
stopifnot(cachedMatrix$isInCache() == FALSE)

#Case 3, compute the inverse of the matrix
inv <- cachedMatrix$inverse()
stopifnot(inv == expected_inverse)

#Case 4, check if the value is in cache this time around
stopifnot(cachedMatrix$isInCache() == TRUE)

#Case 5, Get the inverse again and it should return the same result as last time
inv <- cachedMatrix$inverse()
stopifnot(inv == expected_inverse)

#Case 6, test the cache solve method
inv <- cacheSolve(cachedMatrix)
stopifnot(inv == expected_inverse)