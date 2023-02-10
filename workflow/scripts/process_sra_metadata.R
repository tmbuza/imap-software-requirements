#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

# NCBI BioProject PRJNA685168: Bushmeat samples
library(tidyverse, suppressPackageStartupMessages())
metadata <- read_csv("data/metadata/SraRunTable_bushmeat.csv", show_col_types = FALSE) %>%  
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
  
  write_csv(metadata, "data/metadata/bushmeat.csv")


# NCBI BioProject PRJNA685168: Multi-Omics response to biologic therapies in IBD
  library(tidyverse, suppressPackageStartupMessages())
  metadata <- read_csv("data/metadata/SraRunTable_ibd.csv", show_col_types = FALSE) %>%  
    rename_all(tolower) %>% 
    distinct(., sample_id, .keep_all = TRUE) %>% 
    # rename(sample_id = run) %>% 
    drop_na(lat_lon) %>% 
    # mutate(
    #   geo_loc_name = str_replace_all(geo_loc_name, "Tanzania: ", ""),
    #   geo_loc_name = str_replace_all(geo_loc_name, "The Greater Serengeti Ecosystem", "Serengeti"),
    #   geo_loc_name = str_replace_all(geo_loc_name, " Ecosystem", ""),
    #   isolate = str_replace_all(isolate, "_\\d*$", ""),
    #   lat_lon = str_replace_all(lat_lon, " E$", ""),
    #   latitude = as.numeric(str_replace_all(lat_lon, " S.*", "")) * -1,
    #   longitude = as.numeric(str_replace_all(lat_lon, ".*S ", ""))) %>% 
    rename(wk14 = wk14_remission) %>%
    rename(wk52 = wk52_remission) %>% 
    mutate(bases = round(bases/1E6, digits = 0)) %>% 
    select(sample_id=run, age, sex, bmi, smoking, steriods, antibiotics, biologic, priortnf, wk14, wk52, milionbases=bases)
  
  write_csv(metadata, "data/metadata/ibd.csv")
