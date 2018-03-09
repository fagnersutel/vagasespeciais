library(leaflet)

setwd("~/R-files/vainavaga/")

base <- read.csv('ponto.csv', header = TRUE, sep = ";")
names(base) <- c("lat", "long", "depth", "mag", "stations", "pontoVagas")
base$mag <- as.numeric(base$mag)
dfbase <- base
names(dfbase)
getColor <- function(base) {
  sapply(base$mag, function(mag) {
    if(mag <= 1) {
      "blue"
    } else if(mag <= 2) {
      "green"
    } else if(mag <= 4) {
      "pink"
    } else if(mag <= 6) {
      "orange"
    } else if(mag <= 7) {
      "gray"
    } else if(mag <= 8) {
      "black"
    } else if(mag <= 9) {
      "red"
    } else if(mag <= 12) {
      "purple"
    } else {
      "black"
    } })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(dfbase)
)

leaflet(dfbase) %>% addTiles() %>% 
  addAwesomeMarkers(~long, ~lat, icon=icons, label=~as.character(paste(mag, stations, depth, sep = ", ")), clusterOptions = markerClusterOptions())
