## ----eval=FALSE----------------------------------------------------------
## if(condition) {
##   #code to run if condition is true
## } else if(second condition) {
##   #other code to run if second true
## } else {
##   #finally, code to run if conditions false
## }

## ------------------------------------------------------------------------
x <- c(-100, 100, 10)
if (!is.numeric(x)) {
  print("Numeric input is required")
} else if(all(x > 0)) {
  print("Postive!")
} else {
  x[x < 0] <- NA
  print("Fixed negative values!")
}





## ------------------------------------------------------------------------
for(i in 1:2){
  print(i)  
}
  

## ------------------------------------------------------------------------
library(ggplot2)
cols <- colnames(diamonds)
for(i in cols) {
  print(paste(i, ":", class(diamonds[, i])))
}

## ------------------------------------------------------------------------
i <- 1
while (i <= 5) {
  print(i)
  i <- i + 1
}

## ----eval=FALSE----------------------------------------------------------
## foo <- function(params) {
##   #code goes here
##   return(output)
## }

## ------------------------------------------------------------------------
foo <- function(n = 10) {
  stopifnot(n > 0)
  for(i in 1:n){
    print("Hello, world \n")
  }
}
foo(3)

