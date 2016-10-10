#Clean up a data file so it is more useable  

#First, read it in to make it a dataframe with one header
  #Select the line with the most useful information 
header_weather<-scan("weather.txt", skip=1, nlines = 1,  what = character(), sep="\t")
  #Select all the data
weather<-read.table("weather.txt", skip=4, sep="\t", na.strings = "?", stringsAsFactors = FALSE, quote="")
  #Put the header and the data together
names(weather)<-header_weather

#Lets just work with time, total rainfall, total solar radiation, max air temp, and min air temp

clean<-weather[,c("TIMESTAMP", "Rain_in_Tot", "SlrMJ_Tot", "AirTF_Max", "AirTF_Min")]

#Give the column new names -- "date", "total_rain_in", "total_rad_MJ", "max_temp_F", "min_temp_F"
colnames(clean)<-c("date", "total_rain_in", "total_rad_MJ", "max_temp_F", "min_temp_F")

#Filter the data to make sure you have reasonable values - make unreasonable values "NA"
  #Between 0 and 6 for total rain
clean$total_rain_in[clean$total_rain_in < 0 | clean$total_rain_in > 6]<-NA
  #Between 7 and 30 for total radiation
clean$total_rad_MJ[clean$total_rad_MJ < 7 | clean$total_rad_MJ > 30]<-NA
  #Between -50 and 120 for max temp and -70 and 95 for min temps   
clean$max_temp_F[clean$max_temp_F < -50 | clean$max_temp_F > 120]<-NA
clean$min_temp_F[clean$min_temp_F < -70 | clean$min_temp_F > 95]<-NA
  #max temp cannot be lower than min temp


#Create a rain column in millimeters and temperature columns in degrees C
clean$total_rain_mm<-clean$total_rain_in*25.4
clean$max_temp_C<-clean$max_temp_F*1.8+32
clean$min_temp_C<-clean$min_temp_F*1.8+32

#Now get the date column to read as a date in R 
clean$date<-as.Date(clean$date, "%m/%d/%Y %H:%M")

#Create a column which labels anything before Sept 22 as "summer" and Sept 22 and after as "autumn"
clean$season[clean$date < as.Date("2016-09-22")]<-"summer"  #These don't work
clean$season[clean$date >= 2016-09-22]<-"fall"

#Make a few simple plots of your data to see if it looks okay and everything is the right class
plot(clean$max_temp_C ~ clean$date, type="l")
plot(clean$total_rain_in ~ clean$date, type="h")

#Write the data to a .csv to share with your collaborator
write.csv(clean, file="2016 weather.csv", row.names=FALSE, quote=FALSE)


