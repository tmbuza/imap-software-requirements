from snakemake.utils import min_version

min_version("6.10.0")


# Configuration file
configfile: "config/config.yaml"

import os
import csv
import pandas as pd

# Get the SRA Run accessions
ACC_LIST=pd.read_csv('config/SraRunTable.csv')
ACCESSIONS=ACC_LIST['Run'].tolist() # Specify the column containing the accession, in this demo is Run

OUTDIR="data/reads" 
TEMPDIR=OUTDIR+"/temp"

if not os.path.exists(OUTDIR):
   os.makedirs(OUTDIR)
TEMPDIR=OUTDIR+"/temp"

if not os.path.exists(TEMPDIR):
   os.makedirs(TEMPDIR)



rule all:
    input:
        expand("{outdir}/{accession}_1.fastq", outdir=OUTDIR, accession=ACCESSIONS),
        expand("{outdir}/{accession}_2.fastq", outdir=OUTDIR, accession=ACCESSIONS)


# Dowload the SRA RUN reads
rule download_srareads: 
    output:
        "{outdir}/{accession}_1.fastq",
        "{outdir}/{accession}_2.fastq"
    params:
        download_folder=OUTDIR,
        tempfolder=TEMPDIR
    threads: 1
    shell:
        "fasterq-dump {wildcards.accession} -O {params.download_folder} --temp {params.tempfolder} --threads {threads}"