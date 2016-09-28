## ------------------------------------------------------------------------
#addition, subtraction, multiplications, powers
2 + 3
3^3
2/7
3*108

#modulo (remainder)
33%%4 

## ------------------------------------------------------------------------
#pass values to functions as parameters
log(2, base = 2)
exp(1)
cos(2*pi)

## ------------------------------------------------------------------------
#assignment
x <- 10
y <- cos(2*pi)

## ------------------------------------------------------------------------
#calculation on variable values
exp(x)
x^y

## ------------------------------------------------------------------------
#combine values
(nightstand_books <- c("Harry Potter and the Goblet of Fire", "A Storm of Swords", "On Writing Well", "Advanced R", "R Packages"))

#sequences
(nums <- 1:10)
(nums_2 <- seq(1, 10, by = 2))

## ------------------------------------------------------------------------
head(mtcars)

## ------------------------------------------------------------------------
#accessing data using $
head(mtcars$mpg)

## ------------------------------------------------------------------------
#accessing data using numeric indexing
mtcars[1:6, 1]
mtcars$mpg[1]

#accessing data using string names of columns
mtcars[c(1, 3, 5), "mpg"]

## ------------------------------------------------------------------------
#logicals
3 < 5
x <- c(2, 4, 5, NA, 100)
is.na(x)

## ------------------------------------------------------------------------
#indexing with logicals
x[!is.na(x)]
x[x > 10]
x[x > 10 & !is.na(x)]

## ------------------------------------------------------------------------
#using indexing to change certain values
hp_per_cyl <- mtcars$hp/mtcars$cyl
hp_per_cyl[1] <- NA
hp_per_cyl[2] <- "???"
hp_per_cyl[1:10]

#add column
mtcars$hp_per_cyl <- hp_per_cyl
head(mtcars, 1)

## ------------------------------------------------------------------------
#structure
str(mtcars[, 1:3])

#type conversion
as.character(mtcars$mpg)[1:6]

## ------------------------------------------------------------------------
#moar functions
x <- mtcars$mpg
length(x)
sum(x)

## ------------------------------------------------------------------------
#basic statistical functions
mean(x)
sd(x)
summary(x)
quantile(x, probs = 0.5)

