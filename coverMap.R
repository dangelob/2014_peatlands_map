# Install
# require(devtools)
# install_github('ramnathv/rCharts@dev')
# install_github('ramnathv/rMaps')

library(rMaps)
library(rCharts)
library(plyr)

df <- read.csv("data/peatland_cover.csv")

datm2 <- transform(df,
#                    country = country.abb[match(as.character(country), country.name)],
#                    fillKey = cut(surface_area, quantile(surface_area, seq(0, 1, 1/5)), labels = LETTERS[1:5]),
                   fillKey = cut(surface_area, quantile(surface_area, seq(0, 1, 1/5)), labels = LETTERS[1:5]),
                   year = as.numeric(substr(year, 1, 4))
)

fills = setNames(
  c(RColorBrewer::brewer.pal(5, 'YlOrRd'), 'white'),
  c(LETTERS[1:5], 'defaultFill')
)

dat2 <- dlply(na.omit(datm2), "year", function(x){
  y = toJSONArray2(x, json = F)
  names(y) = lapply(y, '[[', 'country')
  return(y)
})


options(rcharts.cdn = TRUE)
map <- Datamaps$new()
map$set(
  dom = 'chart_1',
  scope = 'world',
  fills = fills,
  data = dat2[[1]],
  legend = TRUE,
  labels = TRUE
)
map


crosslet(
  x = "country", 
  y = c("surface_area"),
  data = dat2
)
