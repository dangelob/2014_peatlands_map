### Basic packages ###
library(sp)             # classes for spatial data
library(raster)         # grids, rasters
library(rasterVis)      # raster visualisation
library(maps)
library(maptools)   # For shapefile
library(mapproj)
library(scales)       # For transparency
# and their dependencies
###########################################################
### VISUALISATION OF GEOGRAPHICAL DATA ###

library(rworldmap)
library(rworldxtra) # Fond de carte haute res
library(GISTools) # North arrow (need rgeos)


savpth <- "/home/dangelo/Documents/4.ScienceStuff/2.Projects/2014_peatlands_map/graphs"

# load data ---------------------------------------------------------------
data("countriesHigh")

locs <- read.csv("data/SNO_sitesCoord.csv")
coordinates(locs) <- c("lon", "lat")  # set spatial coordinates
crs.geo <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84")  # geographical, datum WGS84
proj4string(locs) <- crs.geo  # define projection system of our data

# colors setup ------------------------------------------------------------
bluepres <- "#5F7B8B"
orangepres <- "#E14005"


# France uniquement
pdf(file.path(savpth, "SNO_siteLocalisation.pdf"))
plot(countriesHigh[which(countriesHigh$SOVEREIGNT == "France"),],
     xlim=c(-3.5, 8), # correspond a lon
     ylim=c(41.5,51), # correspond a lat 
#      fill=T,
     col="gray95")

plot(locs, pch = 20, cex = 2, col = "royalblue4", add=T)
text(locs,labels=locs$site, add=T, pos=3, col = "royalblue4")
map.scale(ratio = FALSE, relwidth= 0.4, cex= .8)
#box()#put a box around the map
dev.off()


# EUROPE
pdf(file.path(savpth, "SNO_siteLocalisation_EU.pdf"))
xmin <- 2
xmax <- 4
ymin <- 40
ymax <- 57

plot(countriesHigh[which(countriesHigh$REGION == "Europe"),],
     xlim=c(xmin, xmax), # correspond a lon
     ylim=c(ymin, ymax), # correspond a lat 
#      fill=T,
     border="gray60",
     col="gray95")
plot(countriesHigh[which(countriesHigh$SOVEREIGNT == "France"),],
     xlim=c(xmin, xmax), # correspond a lon
     ylim=c(ymin, ymax), # correspond a lat 
#      fill=T,
     border="gray10",
#      col=bluepres,
     col="gray80",
     add=T)

plot(locs, pch = 20, cex = 2, col = orangepres, add=T)
text(locs,labels=locs$ID_site, pos=c(1,4,1,4), cex=1.1, col = orangepres)
mtext("BDZ: Bernadouze (1400 m), FRN: Frasne (840 m),\nLDM: Landemarais (155 m), LGT: La Guette (145 m)", side=1 , line=1.8, adj=0, cex=1.3, col="black") 
# text(x=2.7, y=40, label=, add=T, cex=1.1)
maps::map.scale(x=-10,y=45, ratio = FALSE, relwidth= 0.15, cex= .8)
# map.cities(country=c("France", "Austria"), capitals=1, pch=15, label=TRUE, cex=.6, col=bluepres)
north.arrow(xb=-7.5, yb=46, len=0.4, lab="N")
map.cities(country="France", capitals=1, pch=15, label=TRUE, cex=.8, col="black")
map.cities(country="Austria", capitals=1, pch=15, label=TRUE, cex=.8, col="black", pos=3)
box(col=bluepres)
dev.off()


###########################################################
# library(mapdata)
# map("worldHires",
#     "France", 
#     xlim=c(-5, 10), # correspond a lon
#     ylim=c(41.5,51), # correspond a lat 
#     col="gray90",
#     fill=TRUE)
# 
# map(database= "world", 
#     xlim=c(-5, 10), # correspond a lon
#     ylim=c(41.5,51), # correspond a lat 
#     col="grey80", 
#     fill=TRUE, 
#     projection="gilbert", 
#     orientation= c(90,100,225))
# plot(locs, pch = 20, cex = 2, col = "steelblue", add = T) 
