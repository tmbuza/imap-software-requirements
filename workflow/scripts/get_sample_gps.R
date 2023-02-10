#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

source("workflow/scripts/common.R")
library(tidyverse, suppressPackageStartupMessages())

metadata <- read_csv("data/metadata/bushmeat.csv", show_col_types = FALSE)

# Sample GPS
library(leaflet)
library(leaflet.providers)
library(htmlwidgets)
library(webshot)
library(mapview)

minLat <- min(metadata$latitude) - 1
minLon <- min(metadata$longitude) + 0
maxLat <- max(metadata$latitude) + .5
maxLon <- max(metadata$longitude) + 0

m <- metadata %>%
  leaflet() %>% 
  addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
  fitBounds(minLon, minLat, maxLon, maxLat) %>%
  addMarkers(lng = ~longitude, lat = ~latitude, popup = ~isolate, label = ~ c(isolate)) %>%
  addCircles(color="magenta", radius = log1p(metadata$longitude) * 10)

## save html to png
saveWidget(m, "images/sample_gps.html", selfcontained = FALSE)
webshot("images/sample_gps.html", file = "images/sample_gps.png",
        cliprect = "viewport")