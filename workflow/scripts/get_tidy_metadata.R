#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

library(tidyverse, suppressPackageStartupMessages())

metadata <- read_csv("data/metadata/SraRunTable.csv", show_col_types = FALSE) %>%  
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


  