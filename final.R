# Extração do MySQL
#SELECT pontoLat, pontoLong, pontoEnd, idtipoSinal, tipoSinalDesc, pontoVagas
#FROM ponto p, tipoSinal t 
#WHERE p._idtipoSinal = t.idtipoSinal

#http://rpubs.com/sirelena/DP1R_Markdown_and_Leaflet
# SELECT pontoLat, pontoLong, pontoEnd, _idtipoSinal, tipoSinalDesc, pontoVagas FROM ponto p, tipoSinal t WHERE p._idtipoSinal = t.idtipoSinal


library(leaflet)
library(yaml)
setwd("~/R-files/vainavaga/")

base <- read.csv('tipoSinal.csv', header = TRUE, sep = ";", fileEncoding = "UTF-8")
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
      "orange.png"
    } else if(mag <= 7) {
      "gray"
    } else if(mag <= 8) {
      "black"
    } else if(mag <= 9) {
      "red"
    } else if(mag <= 12) {
      "purple"
    } else if(mag <= 13) {
      "pink"
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
  addAwesomeMarkers(~long, ~lat, icon=icons, label=~as.character(paste(mag, stations, depth, "Vagas:", pontoVagas, sep = ", ")), clusterOptions = markerClusterOptions())



leafIcons <- icons(
  sapply(base$mag, function(mag) {
    if(mag <= 1) {
      "img/1.png"
    } else if(mag <= 2) {
      "img/2.png"
    } else if(mag <= 3) {
      "img/3.png"
    } else if(mag <= 4) {
      "img/4.png"
    } else if(mag <= 5) {
      "img/5.png"
    } else if(mag <= 6) {
      "img/6.png"
    } else if(mag <= 7) {
      "img/7.png"
    } else if(mag <= 8) {
      "img/8.png"
    } else if(mag <= 9) {
      "img/9.png"
    } else if(mag <= 10) {
      "img/10.png"
    } else if(mag <= 11) {
      "img/11.png"
    } else if(mag <= 12) {
      "img/12.png"
    } else if(mag <= 13) {
      "img/13.png"
    } else if(mag <= 14) {
      "img/14.png"
    } else if(mag <= 15) {
      "img/15.png"
    } else if(mag <= 16) {
      "img/16.png"
    } else if(mag <= 17) {
      "img/17.png"
    } else if(mag <= 18) {
      "img/18.png"
    } else if(mag <= 19) {
      "img/19.png"
    } else {
      "img/10.png"
    } }),
  iconWidth = 45, iconHeight = 45,
  iconAnchorX = 22, iconAnchorY = 94,
  shadowUrl = "img/sombra.png",
  shadowWidth = 50, shadowHeight = 10,
  shadowAnchorX = 20, shadowAnchorY = 52
)


leaflet(dfbase) %>% addTiles() %>% 
  addMarkers(~long, ~lat, icon=leafIcons, label=~as.character(paste( stations,",", depth,",", pontoVagas,"Vagas", sep = " ")), clusterOptions = markerClusterOptions())

