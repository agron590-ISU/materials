## ---- echo=FALSE, message=FALSE------------------------------------------
library(dplyr)
data(baseball, package="plyr")

## ------------------------------------------------------------------------
filter(baseball, team == "HOU" & year == 2005)

## ------------------------------------------------------------------------
astros_ws <- filter(baseball, team == "HOU" & year == 2005)
arrange(astros_ws, desc(hr), desc(rbi), g)

## ------------------------------------------------------------------------
select(astros_ws, id, hr, rbi, g)

## ----echo = FALSE--------------------------------------------------------
# other AWESOME ways to subset
# select(astros_ws, id:bb)
# select(astros_ws, -(X2b:gidp))
# select(astros_ws, starts_with("X"))

## ------------------------------------------------------------------------
head(distinct(select(baseball, team)))

## ------------------------------------------------------------------------
head(mutate(baseball, ba = h/ab))

## ------------------------------------------------------------------------
baseball %>%
  group_by(id) %>%
  summarise(ba = mean(h/ab)) %>% 
  tail(2)

