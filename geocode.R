# Geocoding a csv column of "addresses" in R

#load ggmap
#install.packages('ggmap')
library(ggmap)

# Select the file from the file chooser
fileToLoad <- file.choose(new = TRUE)

# Read in the CSV data and store it in a variable 
origAddress <- read.csv("geocode.csv", stringsAsFactors = FALSE)
origAddress
#origAddress <- read.csv("", stringsAsFactors = FALSE)
# Initialize the data frame
geocoded <- data.frame(stringsAsFactors = FALSE)

# Loop through the addresses to get the latitude and longitude of each address and add it to the
# origAddress data frame in new columns lat and lon
for(i in 1:nrow(origAddress)){
  # Print("Working...")
  result <- geocode(origAddress$addresses[i], output = "latlona", source = "google")
  origAddress$lon[i] <- as.numeric(result[1])
  origAddress$lat[i] <- as.numeric(result[2])
  origAddress$geoAddress[i] <- as.character(result[3])
}
# Write a CSV file containing origAddress to the working directory
write.csv(origAddress, "saida.csv", row.names=FALSE)

