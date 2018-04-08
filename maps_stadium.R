library(rgdal)
library(ggmap)

u <- "https://gist.githubusercontent.com/cageyjames/9142310/raw/4c66392fdccf31282ec5bac94c89455f8d31d4cb/ballparks.geojson"
downloader::download(url = u, destfile = "stadium.GeoJSON")
stadium <- readOGR(dsn = "stadium.GeoJSON", layer = "OGRGeoJSON")

# Convert to dataframe
stadium <- as.data.frame(stadium)

# Filter out MLB teams
stadium_mlb <- stadium %>% 
  filter(League == "MLB")

# Rename variables
stadium_mlb <- stadium_mlb %>% 
  rename(team = Team,
         lat = Lat,
         long = Long)

map <- get_map(location = 'United States', zoom = 4)
#  Visualize the basic map
ggmap(map) +
  geom_point(aes(x = long, y = lat), size = 3, col = "red",
             data = stadium_mlb)
