## Generating spatial points for camera trap placement 
library(sf)
library(raster)
library(dplyr)
library(tmap)    # for static and interactive maps
library(leaflet) # for interactive maps
library(ggplot2)
library(rgdal)
library(rgeos)
library(here)
#read in shape files 
#Gosforth park nature reserve boundary
gp <- st_read(dsn = here("Data_raw"),  layer = "GPNR")
gp <- st_set_crs(gp,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gp <- st_transform(gp, crs = 27700)

# -100m buffer
gp10 <- st_read(dsn = here("Data_raw"),  layer = "GP100")
gp10 <- st_set_crs(gp10,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gp10 <- st_transform(gp10, crs = 27700)

# -200m buffer
gp20 <- st_read(dsn = here("Data_raw"),  layer = "GP200")
gp20 <- st_set_crs(gp20,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gp20 <- st_transform(gp20, crs = 27700)

# -300m buffer
gp30 <- st_read(dsn = here("Data_raw"),  layer = "GP300")
gp30 <- st_set_crs(gp30,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gp30 <- st_transform(gp30, crs = 27700)


# water area

gpwat <- st_read(dsn = here("Data_raw"),  layer = "gnpr_waterbods")
gpwat <- st_set_crs(gpwat,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gpwat <- st_transform(gpwat, crs = 27700)

# generating rings within the reserve boundary
#st_difference y = inner x = outer to get space between boundary and 50m in

edge10 <- st_difference(x = gp, y = gp10)
edge20 <- st_difference(x = gp10, y = gp20)
edge30 <- st_difference(x = gp20, y = gp30)
edge40 <- gp30

# remove water area from each 
#st_difference keep x remove water (y)
edge10 <- st_difference(x = edge10, y = gpwat)
edge20 <- st_difference(x = edge20, y = gpwat)
edge30 <- st_difference(x = edge30, y = gpwat)
edge40 <- st_difference(x = edge40, y = gpwat)


plot(edge10$geometry)
plot(edge20$geometry, add = TRUE)
plot(edge30$geometry, add = TRUE)
plot(edge40$geometry, add = TRUE)

# tree <- st_sample(edge10, 1)
# treebuff <- st_buffer(tree, 50)
plot(edge10$geometry)
#trees10 <- st_sample(edge10, 5)
plot(trees10, add = TRUE, col = "blue")

plot(edge20$geometry,add = TRUE)
#trees20 <- st_sample(edge20, 5)
plot(trees20, add = TRUE, col = "red")

plot(edge30$geometry,add = TRUE)
#trees30 <- st_sample(edge30, 5)
plot(trees30, add = TRUE, col = "green")

#trees40 <- st_sample(edge40, 5)
plot(trees40, add = TRUE, col = "purple")

#save randomly generated points 

trees <- c(trees10,trees20,trees30,trees40)
tdf <- as.data.frame(trees)
#write.csv(tdf, "Data_raw/trees.csv")


#plotting code doesn't always work?
# plot(gp["Name"], col = "blue")
# plot(gp50["Name"], add= TRUE, col = "green")
# plot(trees, add= TRUE, col = "red")

 # adding a note 
#Failed attempt at creating spatial point from buffering 
# #create polygon from boundary points 
# library(readxl)
# #import points
# bound_points <- read_excel(here("Data_raw", "Boundary_points.xlsx"))
# # create polygon
# gp <- st_polygon(list(as.matrix(bound_points)))


