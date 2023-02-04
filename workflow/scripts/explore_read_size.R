#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

library(tidyverse, suppressPackageStartupMessages())

metadata <- read_csv("data/metadata/metadata.csv", show_col_types = FALSE) %>%

cat("\nAscending order\n")
metadata %>% 
  select(isolate, ecosystem, milionbases) %>% 
  arrange(milionbases) %>% 
  head() %>% 
  write_csv("data/metadata/read_size_asce_group.csv")

cat("\n\nDescending order\n")
metadata %>% 
  select(isolate, ecosystem, milionbases) %>% 
  arrange(-milionbases) %>% 
  head() %>% 
  write_csv("data/metadata/read_size_desc_group.csv")