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
TEMPDIR="data/reads/temp"

# Create outdir
if not os.path.exists(OUTDIR):
   os.makedirs(OUTDIR)

# Master rule for controlling workflow.
rule all:
    input:
        expand("{outdir}/{accession}_1.fastq", outdir=OUTDIR, accession=ACCESSIONS),
        expand("{outdir}/{accession}_2.fastq", outdir=OUTDIR, accession=ACCESSIONS),

# Wildcard name must be accession, pointing to an SRA number
rule download_sra_reads:
    output:
        "data/reads/{accession}_1.fastq",
        "data/reads/{accession}_2.fastq",
    log:
        "logs/reads/{accession}.log"
    params:
        download_folder=OUTDIR,
        temp_folder=TEMPDIR
    threads: 1 # defaults to 6
    shell:
        """
        fasterq-dump {wildcards.accession} -t {params.temp_folder} -O {params.download_folder} --threads {threads}
        rm -rf temp_folder
        """
