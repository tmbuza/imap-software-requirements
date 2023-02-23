#!/bin/bash

# 16S rRNA from bushmeat samples (multispecies) collected from Tanzania Metagenome (133 samples, 16GB)
esearch -db sra -query 'PRJNA477349[bioproject]' |  efetch -format runinfo >data/metadata/runinfo_PRJNA477349.csv;
esearch -db sra -query 'PRJNA477349[bioproject]' | esummary | xtract -pattern DocumentSummary -element Run@acc  >data/metadata/ACC_PRJNA477349.txt;

# # Human gut microbiota 16S rRNA gene sequence reads (239 samples, 10GB)
esearch -db sra -query 'PRJDB10610[bioproject]' |  efetch -format runinfo >data/metadata/runinfo_PRJDB10610.csv;
esearch -db sra -query 'PRJDB10610[bioproject]' | esummary | xtract -pattern DocumentSummary -element Run@acc  >data/metadata/ACC_PRJDB10610.txt;

# # Alterations of the gut microbiome in hypertension (117 samples, 628GB)
esearch -db sra -query 'PRJEB21612[bioproject]' |  efetch -format runinfo >data/metadata/runinfo_PRJEB21612.csv;
esearch -db sra -query 'PRJEB21612[bioproject]' | esummary | xtract -pattern DocumentSummary -element Run@acc  >data/metadata/ACC_PRJEB21612.txt;

# # Antihypertensive therapy by ACEI/ARB is associated with intestinal flora alterations and metabolomic profiles in patients with essential hypertension
# # ACEI/ARB impact gut microbiome and metabolome (55 samples, 3GB)
esearch -db sra -query 'PRJEB50682[bioproject]' |  efetch -format runinfo >data/metadata/runinfo_PRJEB50682.csv;
esearch -db sra -query 'PRJEB50682[bioproject]' | esummary | xtract -pattern DocumentSummary -element Run@acc  >data/metadata/ACC_PRJEB50682.txt;

# esearch -db sra -query 'SRR390728' \
#   | efetch -format runinfo \
#   | cut -f1,12 -d,
  
