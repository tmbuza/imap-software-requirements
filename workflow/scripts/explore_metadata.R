#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

source("workflow/scripts/common.R")
library(tidyverse, suppressPackageStartupMessages())

metadata <- read_csv("data/mothur/metadata/SraRunTable10.csv", show_col_types = FALSE) %>%  
  rename_all(tolower) %>% 
  rename(sample_id = run) %>% 
  drop_na(lat_lon) %>% 
  mutate(
    geo_loc_name = str_replace_all(geo_loc_name, "Tanzania: ", ""),
    geo_loc_name = str_replace_all(geo_loc_name, "The Greater Serengeti Ecosystem", "Serengeti"),
    geo_loc_name = str_replace_all(geo_loc_name, " Ecosystem", ""),
    isolate = str_replace_all(isolate, "_\\d*$", ""),
    lat_lon = str_replace_all(lat_lon, " E$", ""),
    latitude = as.numeric(str_replace_all(lat_lon, " S.*", "")) * -1,
    longitude = as.numeric(str_replace_all(lat_lon, ".*S ", ""))) %>% 
  rename(ecosystem = geo_loc_name) %>%
  rename(description = host) %>% 
  mutate(bases = round(bases/1E6, digits = 0)) %>% 
  select(sample_id, ecosystem, isolate, latitude, longitude, milionbases=bases, description)
  
  write_csv(metadata, "data/metadata/metadata.csv")


metadata %>% 
  select(isolate, ecosystem, milionbases) %>% 
  arrange(milionbases)

  metadata %>% 
  ggplot(aes(x = isolate, y = milionbases, fill = ecosystem)) +
  facet_grid(~ ecosystem) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(x = "Animal Name", y = "Read size (milion bases)") +
  theme_light()

ggsave(file="images/variables.png", width=10, height=10)
ggsave(file="images/variables.svg", width=10, height=10)


library(leaflet)
# library(leaflet.esri)
library(leaflet.providers)
# library(leaflet.extras)
# library(data.table)
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