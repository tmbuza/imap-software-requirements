#!/Users/tmbuza/opt/anaconda3/envs/snakemake/bin/Rscript

source("workflow/scripts/common.R")
library(tidyverse, suppressPackageStartupMessages())


read_csv("data/metadata/bushmeat.csv", show_col_types = FALSE) %>%
  ggplot(aes(x = isolate, y = milionbases, fill = ecosystem)) +
  facet_grid(~ ecosystem) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(x = "Animal Name", y = "Read size (milion bases)") +
  theme_light()

ggsave(file="images/bush_variable_freq.svg", width=10, height=10)


read_csv("data/metadata/ibd.csv", show_col_types = FALSE) %>%
  ggplot(aes(x = antibiotics, y = milionbases, fill = biologic)) +
  facet_grid(~ sex) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(x = "Taking Antibiotic", y = "Read size (milion bases)") +
  theme_light()

ggsave(file="images/ibd_variable_freq.svg", width=10, height=10)



