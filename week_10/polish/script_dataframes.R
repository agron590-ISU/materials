#This script is meant to illustrate subsetting and does not necessarily demostrate the most efficient coding
#practices. Here we import a dataset from National Agricultural Statitistics Service 
#(NASS, https://quickstats.nass.usda.gov/) that focuses on field crops in Iowa.

#Use this to check and set your working directory (or toolbar in RStudio)
getwd()
#setwd()

library(readr) 
crops<-read_csv("NASS-Iowa.csv")  #ctr+enter or command+enter will run the line you are on 

head(crops)  #If you want to glance at the data
tail(crops)  # BTW, hashtag is used to insert commments

#Let's get rid of some columns

  #Choose the columns you want to keep
  fewer_columns<-crops[,c("Year", "State", "Commodity", "Data Item", "Value")]

  #Can also specify by column number  
  notsomany_columns<-crops[,c(2, 6, 16 ,17, 20)]

#Let's get rid of some rows - like everything, there are a lot of ways to do the same thing 
  
  recent<-fewer_columns[fewer_columns$Year != 1866, ]
  
  recent<-fewer_columns[fewer_columns$Year %in% c(1867:2015),]  
  
  recent<-fewer_columns[1:6819,]  
  
#Now let's subset soybeans, just bushels per acre  
  beans<-recent[recent$Commodity == "SOYBEANS" & 
          recent$`Data Item` == "SOYBEANS - YIELD, MEASURED IN BU / ACRE",]  
  
#These columns names are driving me crazy, let's rename  
  colnames(beans)<-c("year", "state", "commodity", "measure", "bu_acre")  
  beans<-beans[,-4] #We don't even need this column, let's remove
  
#Add a unit conversion as a new column
  beans$Mg_ha<-beans$bu_acre*60*0.00045*0.40
 
#Fit a linear model to examine the relationship between time and yield
mod<-lm(beans$bu_acre ~ beans$year)

#Look at the summary
summary(mod)

#Look at names of things the model gives us
names(summary(mod))

#What does it mean by "coefficients"?
summary(mod)$coefficients

#Extract the p-value
summary(mod)$coefficients[,4] 

#Extract the R squared
summary(mod)$r.squared

#Here is something that was extracted (R^2) being useful
library(ggplot2)

#ggplot(beans, aes(x=year, y=bu_acre))+
  #geom_point()+
  #geom_smooth(method='lm')+
  #annotate("text", x=1940, y=50, label = summary(mod)$r.squared, size=5, parse=TRUE)


#######################################################
#Now we want to look at small grains as a group
#Subset most of the small grains listed
smlgrains<-fewer_columns[fewer_columns$Commodity %in% c("OATS", "BARLEY", "WHEAT", "RYE") & 
                       fewer_columns$`Data Item` %in% c("OATS - ACRES HARVESTED","BARLEY - ACRES HARVESTED",
                                                       "WHEAT - ACRES HARVESTED","RYE - ACRES HARVESTED"),]

#These data from NASS have a comma in them and we have to remove it by
 #substituting "nothing" in the place of the comma. You will run into random problems like
 #this a lot and you will always get past it. . .somehow 
smlgrains$Value<-as.numeric(gsub(",", "", smlgrains$Value))

#Here is a glimpse of your future with an awesome package (dplyr)
library(dplyr)
total_smlgrains<-group_by(smlgrains, Year)%>%
  summarise(total=sum(Value))
  
#Check it out 
#plot(total_smlgrains$total~total_smlgrains$Year)

#####################################################
#Don't see many small grains these days, but I do see soybeans. I wonder about the 
 #relationship. Let's compare acre amounts

#Back to beans and this time subset "acres harvested"
bean_acres<-recent[recent$Commodity == "SOYBEANS" & 
                recent$`Data Item` == "SOYBEANS - ACRES HARVESTED",] 

#Now let's work to get the "bean_acres" dataframe and "total_smlgrains" dataframe to 
 #look identical so we tack them together for a tidy result
bean_acres<-bean_acres[,c(1,5)] #this is the information we actually need
colnames(bean_acres)<-c("year", "acres")

#Okay, should have left 'Commodity' in there, but now we don't 
  #have to have SOYBEANS shouted at us
bean_acres$crop<-"soybeans" 

#Make matching column names and "crop" label for total_smlgrains  
colnames(total_smlgrains)<- c("year", "acres")
total_smlgrains$crop<-"smlgrains"

#Now, R, bind these rows together (rbind)
both<-rbind(bean_acres, total_smlgrains)

#Here's a story about cropland use in Iowa
ggplot(both, aes(x=year, y=acres, group=crop, color=crop))+
  geom_point()+
  geom_smooth()