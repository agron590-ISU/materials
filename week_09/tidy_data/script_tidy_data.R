
#Load dplyr, ggplot2, tidyr and a few others (tibble)
library(tidyverse)

#Make a dataframe that isn't tidy
df<-data.frame(property=c("pH", "NO3", "clay", "silt", "sand"),
               five_cm = c(7, 35, 20, 20, 60),
               ten_cm = c(6.7, 22, 20, 20, 60),
               fifteen_cm = c(6.5, 20, 20, 20, 60),
               twenty_cm = c(6.4, 18, 20, 20, 60),
               stringsAsFactors=FALSE)

soil<-as_tibble(df)

#Make the tibble tidy
tidy_soil<-gather(soil, five_cm, ten_cm, fifteen_cm, twenty_cm, 
                  key=depth, value=value)

#Simply make a simple figure
filter(tidy_soil, property == "pH")%>%
  ggplot(aes(x=depth, y=value))+
  geom_point(size=3)
 
  
#*********************************************************
#Find some data that need to be spread out

crops<-read_csv("data/NASS-Iowa.csv")

oats<-(crops[crops$Commodity == "OATS", c(2, 16, 17, 20)])  
head(oats)

spread(oats, key = `Data Item`, value = Value)

 
spread(oats, key = `Data Item`, value = Value)%>%
  ggplot(aes(y=`OATS - YIELD, MEASURED IN BU / ACRE`,
             x = `OATS - ACRES HARVESTED`, label = Year))+

#**************************************************************
#Another example of a tibble that benfits from `gather`
biomass<-data.frame(trt = c("0", "100", "130", "150"),
                    block = c("A", "A", "A", "A"),
                    part=c("leaf", "stem", "fruit", "root"),
                    may = c(5.5, 5.7, 0, 12.0),
                    june = c(7.5, 6.7, 2.0, 14.0),
                    july = c(12.5, 7.7, 8.2, 22.5),
                    august = c(12.5, 7.7, 8.8, 22.0),
                    stringsAsFactors=FALSE)

biomass<-as_tibble(biomass)
biomass

gather(biomass, may, june, july, august, key = month, value = g_m2)

#Now spread the data for some reason
biomass_tidy<-gather(biomass, may, june, july, august, key = month, value = g_m2)

spread(biomass_tidy, key = part, value = g_m2)
  

