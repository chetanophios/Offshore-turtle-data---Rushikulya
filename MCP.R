#load necessary packages
library(sf)
library(sp)
library(adehabitatHR)
library(rgdal)
library(scales) 
library(ggplot2)
library(ggmap)
library(viridis)
library(geosphere)
library(dplyr)
library(maps)
library(forcats)

#read data. Mastersheet from Rao et al_2023_spatial.csv
turtlesdec <- read.csv("~/Desktop/Turtle paper/Data/Spatial data/Map files/CSV files/data.csv", stringsAsFactors = FALSE)
turtlesjan<-read.csv("~/Desktop/Turtle paper/Data/Spatial data/Map files/CSV files/data.csv", stringsAsFactors = FALSE)
turtlesfeb<-read.csv("~/Desktop/Turtle paper/Data/Spatial data/Map files/CSV files/data.csv", stringsAsFactors = FALSE)

#set coordinates from point file and define projections
turtles.sp<-turtlesdec[,c ("Sight.Lon", "Sight.Lat")]
coordinates(turtles.sp)<-c("Sight.Lon", "Sight.Lat")
proj4string(turtles.sp)<- CRS ('+proj=longlat +datum=WGS84 +no_defs')

turtles.sp1<-turtlesjan[,c ("Sight.Lon", "Sight.Lat")]
coordinates(turtles.sp1)<-c("Sight.Lon", "Sight.Lat")
proj4string(turtles.sp1)<- CRS ('+proj=longlat +datum=WGS84 +no_defs')

turtles.sp2<-turtlesfeb[,c ("Sight.Lon", "Sight.Lat")]
coordinates(turtles.sp2)<-c("Sight.Lon", "Sight.Lat")
proj4string(turtles.sp2)<- CRS ('+proj=longlat +datum=WGS84 +no_defs')

#convert lat long to UTM
mydata.spdf1<-spTransform(turtles.sp,
                          CRS(
                            "+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
                          )
)



#convert lat long to UTM
mydata.spdf2<-spTransform(turtles.sp1,
                          CRS(
                            "+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
                          )
)


#convert lat long to UTM
mydata.spdf3<-spTransform(turtles.sp2,
                          CRS(
                            "+proj=aea +lat_1=20 +lat_2=-23 +lat_0=0 +lon_0=25 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
                          )
)

#define mcp
dec100<- mcp(mydata.spdf1, percent=100, unin = "m", unout = "km2")
dec75<-mcp(mydata.spdf1, percent= 75, unin = "m", unout = "km2")
dec50<-mcp(mydata.spdf1, percent= 50, unin = "m", unout = "km2")

jan100<-mcp(mydata.spdf2, percent=100, unin = "m", unout = "km2")
jan75<-mcp(mydata.spdf2, percent=75, unin = "m", unout = "km2")
jan50<-mcp(mydata.spdf2, percent=50, unin = "m", unout = "km2")

feb100<-mcp(mydata.spdf3, percent=100, unin = "m", unout = "km2")
feb75<-mcp(mydata.spdf3, percent=75, unin = "m", unout = "km2")
feb50<-mcp(mydata.spdf3, percent=50, unin = "m", unout = "km2")

writeOGR(feb50, dsn = ".", layer = "turtlesfeb2022test_All_50_MCP", driver="ESRI Shapefile") 
writeOGR(feb75, dsn = ".", layer = "turtlesfeb2022test_All_75_MCP", driver="ESRI Shapefile") 
writeOGR(feb100, dsn = ".", layer = "turtlesfeb2022test_All_100_MCP", driver="ESRI Shapefile") 

writeOGR(jan50, dsn = ".", layer = "turtlesjan2021test_All_50_MCP", driver="ESRI Shapefile") 
writeOGR(jan75, dsn = ".", layer = "turtlesjan2021test_All_75_MCP", driver="ESRI Shapefile") 
writeOGR(jan100, dsn = ".", layer = "turtlesjan2021test_All_100_MCP", driver="ESRI Shapefile") 

writeOGR(dec50, dsn = ".", layer = "turtlesdec2021test_All_50_MCP", driver="ESRI Shapefile") 
writeOGR(dec75, dsn = ".", layer = "turtlesdec2021test_All_75_MCP", driver="ESRI Shapefile") 
writeOGR(dec100, dsn = ".", layer = "turtlesdec2021test_All_100_MCP", driver="ESRI Shapefile") 

#For more information, please refer to Calenge (2006)
