#install.packages('lealeft')
library(leaflet)
setwd("~/R-files/vainavaga/")

df1 <- read.csv('ponto.csv', header = TRUE, sep = ";")
df <- df1
names(df)
head(df)
df$idtipoSinal = as.numeric(df$pontoEnd)

getColor <- function(df) {
  sapply(df$idtipoSinal, function(idtipoSinal) {
    if(idtipoSinal == 1) {
      "yellow"
    } else if(idtipoSinal == 2) {
      "orange"
    } else {
      "blue"
    } })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(df)
)

leaflet(df) %>% addTiles() %>%
  addAwesomeMarkers(~pontoLong, ~pontoLat, icon=icons, label=~as.character(paste("Local: ", pontoEnd, "Tipo:", tipoSinalDesc,",", pontoVagas, " vaga(s)", sep = " ")), clusterOptions = markerClusterOptions())



# first 20 quakes
quakes <- read.csv('ponto.csv', header = TRUE, sep = ";")
df.20 <- quakes[1:2000,]

getColor <- function(quakes) {
  sapply(quakes$idtipoSinal, function(idtipoSinal) {
    if(idtipoSinal <= 4) {
      "blue"
    } else if(idtipoSinal <= 5) {
      "green"
    } else {
      "red"
    } })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(df.20)
)

leaflet(df.20) %>% addTiles() %>%
  addAwesomeMarkers(~pontoLong, ~pontoLat, icon=icons, label=~as.character(paste(idtipoSinal, df.20$pontoEnd, df.20$tipoSinalDesc, sep = ", ")), clusterOptions = markerClusterOptions())
