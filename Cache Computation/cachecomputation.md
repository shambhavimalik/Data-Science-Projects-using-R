---
title: "Cache Computation"
author: "Shambhavi Malik"
date: "25/08/2020"
output: html_document
---
## Introduction
In this project we write an R function that is able to cache potentially time-consuming computations. For example, taking the mean of a numeric vector is typically a fast operation. However, for a very long vector, it may take too long to compute the mean, especially if it has to be computed repeatedly (e.g. in a loop). If the contents of a vector are not changing, it may make sense to cache the value of the mean so that when we need it again, it can be looked up in the cache rather than recomputed. We take advantage of the scoping rules of the R language and how they can be manipulated to preserve state inside of an R object.

### Caching the Mean of a Vector
In this we use the <<- operator which can be used to assign a value to an object in an environment that is different from the current environment. Below are two functions that are used to create a special object that stores a numeric vector and caches its mean.

The first function, makeVector creates a special "vector", which is really a list containing a function to:

- set the value of the vector
- get the value of the vector
- set the value of the mean
- get the value of the mean
```{r}
makeVector <- function(x = numeric()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setmean <- function(mean) m <<- mean
        getmean <- function() m
        list(set = set, get = get,
             setmean = setmean,
             getmean = getmean)
}
```

The following function calculates the mean of the special "vector" created with the above function. However, it first checks to see if the mean has already been calculated. If so, it gets the mean from the cache and skips the computation. Otherwise, it calculates the mean of the data and sets the value of the mean in the cache via the setmean function.
```{r}
cachemean <- function(x, ...) {
        m <- x$getmean()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        m <- mean(data, ...)
        x$setmean(m)
        m
}
```

### Caching the Inverse of a Matrix
Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than computing it repeatedly. Thus we write a pair of functions that cache the inverse of a matrix.

Computing the inverse of a square matrix can be done with the solve function in R. For example, if X is a square invertible matrix, then solve(X) returns its inverse.

For this project, we assume that the matrix supplied is always invertible.

The function, makeCacheMatrix creates a special "matrix", which is really a list containing a function to
- set the value of the matrix
- get the value of the matrix
- set the value of the inverse
- get the value of the inverse

```{r}
makeCacheMatrix <- function(x = matrix()) {
  i <- NULL #set value of inverse to null
  set <- function(y)
  {
    x <<- y #x set to a new matrix y
    i <<- NULL #inverse again set to NULL
  }
  get <- function() {x} #returns the special matrix x
  setinv <- function(inv) {i <<- inv} #assigns inv to i
  getinv <- function() {i} #returns the inverse matrix i
  list(set=set, get=get, setinv=setinv, getinv=getinv) 
  #creates a list of all the functions
}
```

The following function calculates the inverse of the special "matrix" created with the above function. However,it first checks to see if the inverse has already been calculated. If so, it gets the inverse from the cache and skips the computation. Otherwise, it calculates the inverse of the data and sets the value of the inverse in the cache via the setinv function.
```{r}
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  i <- x$getinv()
  if(!is.null(i)) { #checks if inverse has been calculated
    message("getting cached data")
    return(i) #returns the calculated value of inverse from cache
  }
  data <- x$get()
  i <- solve(data, ...) #calculates inverse of matrix m and assigns it to i
  x$setinv(i) #returns the inverse matrix i 
  i
}
```
