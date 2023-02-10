library(tidyverse)
read_table("results/stats1/seqkit_stats.txt", show_col_types = F) %>% 
  mutate(sample_id = str_replace_all(file, ".*/", ""), .before=file) %>% 
  mutate(sample_id = str_replace_all(sample_id, "_\\d?.fastq", "")) %>%
  mutate(file = str_replace_all(file, ".*/", "")) %>%
  filter(str_detect(file, "_1" )) %>% 
  mutate(file2 =file, .after = file) %>% 
  mutate(file2 = str_replace_all(file, "_1.fastq", "_2.fastq")) %>%
  distinct() %>% 
  group_by(sample_id) %>%
  # filter(num_seqs <65000) %>% 
  arrange(num_seqs) %>% 
  ungroup() %>%
  select(sample_id, forward = file, reverse = file2) %>% 
  # mutate(forward = str_replace_all(forward, "data/metadata/", "")) %>%
  # mutate(reverse = str_replace_all(reverse, "data/metadata/", "")) %>%
  write_tsv("data/metadata/mothur_mapping_file.tsv")

  