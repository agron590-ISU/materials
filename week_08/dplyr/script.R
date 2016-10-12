## ------------------------------------------------------------------------
data(baseball, package="plyr")
head(baseball)

## ------------------------------------------------------------------------
players <- unique(baseball$id)

## ---- message=FALSE------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
group_by(baseball, id)

## ------------------------------------------------------------------------
summarise(baseball, mean(h))
summarise(group_by(baseball, year), mean(h))

## ---- message=FALSE------------------------------------------------------
baseball %>%
  group_by(id) %>%
  summarise(ba = mean(h/ab)) %>% 
  tail(2)

