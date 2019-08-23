# load the library
library(spdep)
library(rgdal)

# load the data
sp_data <- readOGR("C:\\Users\\Mei\\OneDrive - University of Toronto\\ggr376\\a3\\ecodistricts.geojson")
# load the coordinates in the spatial data
coords <- coordinates(sp_data)
# generate a neighbours list from polygon list
sp_data.FOQ <- poly2nb(sp_data, queen=TRUE, row.names=sp_data$FIPSNO)
# change the neighbour list to a spatial weighted matrix
listw<-nb2mat(sp_data.FOQ)
d <- as.data.frame(listw)
colnames(d) <- c(0,1,2,3,4,5,6,7,8,9,10,11)
table <- as.matrix(d)
# using the spatial data as basemap and neibourlist to map the neighbourhood relation ship
plot(sp_data, border="grey")
plot(sp_data.FOQ, coords, add=TRUE)

