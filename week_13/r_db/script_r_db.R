## ----connect, message=FALSE----------------------------------------------
library(dplyr)

# set up the connection
star_wars <- src_sqlite("data/star_wars.db")

# get a table by name
planet <- tbl(star_wars, "planet")

planet %>%
  filter(population > 1e10) %>%
  summarise(count = n())

## ----sql-----------------------------------------------------------------
# arbitrary sql queries
planet <- tbl(star_wars, sql("SELECT * FROM planet"))

head(planet)

## ----lazy----------------------------------------------------------------
c1 <- filter(planet, population > 1e7 & diameter < 10000)
c2 <- select(c1, name, climate, terrain, gravity, diameter, population)
c3 <- mutate(c2, surface_area = 4*pi*(diameter/2)^2)
c4 <- mutate(c3, pop_area = population/surface_area)
c5 <- arrange(c4, pop_area)

## ----collect-------------------------------------------------------------
# dplyr doesn't actually pull all the data
dim(c5)

# unless we tell it to
c5 %>% collect() %>% dim()

## ----dbi, warning=FALSE--------------------------------------------------
library(DBI)

# connect
sw_con <- dbConnect(dbDriver("SQLite"), "data/star_wars.db")

# list of tables
dbListTables(sw_con)

# get the data
query <- dbSendQuery(sw_con, "SELECT * FROM planet")
planet <- fetch(query)
dim(planet)

# close the connection
dbDisconnect(sw_con)


