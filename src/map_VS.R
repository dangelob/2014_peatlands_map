library(RgoogleMaps)
library(ggmap)

savpth <- "/home/dangelo/Documents/4.ScienceStuff/2.Projects/2014_peatlands_map/graphs"

# embase pt ---------------------------------------------------------------
embase <- read.csv("/home/dangelo/Documents/4.ScienceStuff/2.Projects/2014_peatlands_map/data/embase.csv")

# contour -----------------------------------------------------------------
dat_c <- "/home/dangelo/Documents/4.ScienceStuff/2.Projects/2014_peatlands_map/data/contourLG/1944_Shp_WGS84.shp"
contour<-readShapeSpatial(dat_c, proj4string=CRS("+proj=longlat +datum=WGS84"))
ggcontour <- fortify(contour, region="Id")

# map ---------------------------------------------------------------------
LG <- get_map(location = c(lon=2.2845, lat=47.323000),
        zoom=15,
        color="color",
        source="google",
        maptype="satellite" )

map <- ggmap(LG,
      extent="device",
      ylab="Latitude", 
      xlab="Longitude")+
  coord_fixed(xlim = c(2.2740, 2.2950), ylim = c(47.3200, 47.3270))+
  geom_polygon(aes(x=long, y=lat, group=group), size=.3,color='white', data=ggcontour, alpha=0.01, fill="white")+
  geom_point(aes(x=elon, y=elat), data=embase, size=5.5, shape=21, fill="white")+
  geom_text(aes(x=elon, y=elat, label=elab), data=embase, size=3)

ggsave("testmap_LowRes.png", path = file.path(savpth), dpi=75)
ggsave("testmap_HighRes.png", path = file.path(savpth), dpi=300)



ggmap.contour <- ggplot(ggcontour, aes(x=long, y=lat))+
  geom_polygon(fill=NA, alpha=0)+
  geom_path(color="lightgrey", size=1)+
  coord_equal()+
  theme_bw()