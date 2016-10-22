## ---- eval=FALSE---------------------------------------------------------
## library(ggplot2)
## library(maps)
## 
## load("noaa.rdata")

## ---- echo=FALSE---------------------------------------------------------
library(ggplot2)
library(maps)

load("data/noaa.rdata")

## ------------------------------------------------------------------------
head(floats, n = 2)[,1:5]
head(floats, n = 2)[,6:10]
head(floats, n = 2)[,11:14]

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = floats) + 
    coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = gliders) + 
    coord_map()

## ---- fig.height=4, fig.width=7------------------------------------------
qplot(Longitude, Latitude, colour = callSign, data = boats) + 
    coord_map()

## ---- fig.height=3, fig.width=7, warning=FALSE---------------------------
states <- map_data("state")

ggplot() +
    geom_path(data = states, aes(x = long, y = lat, group = group)) + 
    geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = callSign)) +   
    geom_point(aes(x, y), shape = "x", size = 5, data = rig) + 
    geom_text(aes(x, y), label = "BP Oil Rig", 
              size = 5, data = rig, hjust = -0.1) + 
    xlim(c(-91, -80)) + ylim(c(22,32)) + coord_map()

## ---- eval=FALSE---------------------------------------------------------
## qplot(Longitude, Latitude, colour = callSign, data = floats)

## ---- eval=FALSE---------------------------------------------------------
## ggplot(data = floats,
##        aes(x = Longitude, y = Latitude, colour = callSign)) +
##   geom_point() +
##   scale_x_continuous() +
##   scale_y_continuous() +
##   scale_colour_discrete()

## ---- fig.height=3, fig.width=7------------------------------------------
ggplot(data = floats, 
       aes(x = Longitude, y = Latitude, colour = callSign)) +
  geom_point()

## ---- fig.height=4, fig.width=7, echo=FALSE, warning=FALSE---------------
ggplot(aes(x = Depth, y = Temperature, colour = callSign), data = floats) + geom_point()

## ---- fig.height=3, fig.width=7, warning=FALSE---------------------------
ggplot() +
    geom_path(data = states, aes(x = long, y = lat, group = group)) + 
    geom_point(data = floats, aes(x = Longitude, y = Latitude, colour = callSign)) +   
    geom_point(aes(x, y), shape = "x", size = 5, data = rig) + 
    geom_text(aes(x, y), label = "BP Oil Rig", size = 5, data = rig, hjust = -0.1) + 
    xlim(c(-91, -80)) + 
    ylim(c(22, 32)) + coord_map()

## ------------------------------------------------------------------------
animal <- read.csv("http://heike.github.io/rwrks/02-r-graphics/data/animal.csv")

