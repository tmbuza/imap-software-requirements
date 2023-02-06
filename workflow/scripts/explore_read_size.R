#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

library(tidyverse, suppressPackageStartupMessages())

metadata <- read_csv("data/metadata/metadata.csv", show_col_types = FALSE) 


metadata %>% 
  dplyr::select(isolate, ecosystem, milionbases) %>% 
  group_by(isolate, ecosystem) %>% 
  summarise(milionbases = sum(milionbases), .groups = "drop") %>% 
  arrange(milionbases) %>% 
  head() %>% 
  write_csv("data/metadata/read_size_asce.csv")


metadata %>% 
  dplyr::select(isolate, ecosystem, milionbases) %>% 
  group_by(isolate, ecosystem) %>% 
  summarise(milionbases = sum(milionbases), .groups = "drop") %>% 
  arrange(-milionbases) %>% 
  head() %>% 
  write_csv("data/metadata/read_size_desc.csv")