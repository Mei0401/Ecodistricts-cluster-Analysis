# load the library
library(rgdal)
library(broom)
library(rgeos)
library(ggplot2)
# load the data
sp_data <- readOGR("C:\\Users\\Mei\\OneDrive - University of Toronto\\ggr376\\a3\\modified.geojson")
# Change to a data frame but group by cluster
spatial_cor <- tidy(sp_data, region = "Cluster_cor")
# Split the data into 3 groups that inorder to calculate their center
clus1 <- sp_data[sp_data$Cluster_cor == 1,]
clus2 <- sp_data[sp_data$Cluster_cor == 2,]
clus3 <- sp_data[sp_data$Cluster_cor == 3,]
# get the spatial center for each cluster
center1 <- gCentroid(clus1 ,byid=FALSE)
center2 <- gCentroid(clus2 ,byid=FALSE)
center3 <- gCentroid(clus3 ,byid=FALSE)
# change it to data frame so it can be used in ggplot
p1 <- data.frame(center1)
p2 <- data.frame(center2)
p3 <- data.frame(center3)
# add coordinate attribute for label
p1$coor <- paste(p1$x, p1$y, sep=",")
p2$coor <- paste(p2$x, p2$y, sep=",")
p3$coor <- paste(p3$x, p3$y, sep=",")
# plot the map
ggplot() +
  geom_polygon(data = spatial_cor, aes(long,lat,fill = group))+ # base map
  geom_point(data= p1, aes(x,y), color="yellow")+ # 3 spatial center points
  geom_point(data= p2, aes(x,y), color="yellow")+
  geom_point(data= p3, aes(x,y), color="yellow",show.legend = TRUE)+
  geom_text(data = p1, aes(x,y+0.1,label = coor),size = 4)+ # 3 labels of coordinate
  geom_text(data = p2, aes(x-0.4,y+0.1,label = coor),size = 4)+
  geom_text(data = p3, aes(x-0.4,y-0.1,label = coor),size = 4)+
  ggtitle("Spatial Center Map of 3 cluster in K-Mean for the St. Lawrence River Basin")+ # title
  scale_fill_discrete(name  ="Spatial Center", # legend
                      breaks=c("1.1", "2.1","3.1"),
                      labels=c("Cenntroid in Cluster 1","Cenntroid in Cluster 2","Cenntroid in Cluster 3"))

