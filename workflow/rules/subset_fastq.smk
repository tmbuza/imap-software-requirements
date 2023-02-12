from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

import os
import csv
import pandas as pd

METADATA=pd.read_csv('data/metadata/SraRunTable_bushmeat.csv').loc[0:4]
ACCESSIONS=METADATA['Run'].tolist() # Specify the column containing the accession, in this demo is Run
OUTDIR="data/reads" 
TESTDIR="data/reads/test"

 # Master rule for controlling workflow.
rule all:
    input:
        expand("{testdir}/{accession}_1_sub.fastq", testdir=TESTDIR, accession=ACCESSIONS),
        expand("{testdir}/{accession}_2_sub.fastq", testdir=TESTDIR, accession=ACCESSIONS),


# Subset a test data
rule seqkit_test_subset:
    input:
        expand("{outdir}/{accession}_1.fastq", outdir=OUTDIR, accession=ACCESSIONS),
        expand("{outdir}/{accession}_2.fastq", outdir=OUTDIR, accession=ACCESSIONS),
    output:
        "{testdir}/{accession}_1_sub.fastq",
        "{testdir}/{accession}_2_sub.fastq",
    params:
        subset_folder=TESTDIR,
    threads: 1
    shell:
        """
        bash workflow/scripts/subset_fastq.sh
        """