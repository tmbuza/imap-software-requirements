library(tidyverse)
read_tsv("data/metadata/mothur_mapping_file.tsv", show_col_types = F) %>% 
  select(sample_id) %>% 
  inner_join(., read_csv("data/metadata/bushmeat.csv"), by = "sample_id") %>% 
  select(1:4) %>% 
  head() %>% as.data.frame() %>% 
  select(group = sample_id, var1 = 2) %>% 
  write_tsv("data/metadata/mothur_design_file.tsv")