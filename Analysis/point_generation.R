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

# -50m buffer
gp50 <- st_read(dsn = here("Data_raw"),  layer = "GP50")
gp50 <- st_set_crs(gp50,value = 27700) #espg value for british national grid https://geo.nls.uk/urbhist/guides_coordinates.html
gp50 <- st_transform(gp50, crs = 27700)


# generate points in gp but not gp50
#st_difference y = inner x = outer to get space between boundary and 50m in

edge50 <- st_difference(x = gp, y = gp50)
trees <- st_sample(edge50, 10)

plot(gp["Name"], col = "blue")
plot(gp50["Name"], add= TRUE, col = "green")
plot(trees, add= TRUE, col = "red")
#Failed attempt at creating spatial poin for buffering 
# #create polygon from boundary points 
# library(readxl)
# #import points
# bound_points <- read_excel(here("Data_raw", "Boundary_points.xlsx"))
# # create polygon
# gp <- st_polygon(list(as.matrix(bound_points)))


