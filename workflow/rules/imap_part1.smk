from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/reads/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

sraSamples = list(set(glob_wildcards(os.path.join('data/reads/', '{sample}_{sraNum, [12]}.fastq.gz')).sample))


import os
import csv
import pandas as pd

METADATA=pd.read_csv('data/metadata/SraRunTable.csv').loc[0:1]
ACCESSIONS=METADATA['Run'].tolist() # Specify the column containing the accession, in this demo is Run
OUTDIR="data/reads" 
if not os.path.exists(OUTDIR):
   os.makedirs(OUTDIR)


# Master rule for controlling workflow.
rule all:
    input:
        "results/mothur_mapping_file.tsv"  
        expand("{outdir}/{accession}_1.fastq", outdir=OUTDIR, accession=ACCESSIONS),
        # expand("{outdir}/{accession}_2.fastq", outdir=OUTDIR, accession=ACCESSIONS),

# Get tidy metadata
rule process_metadata:
    output:
        csv="data/metadata/metadata.csv"
    script:
        "scripts/sra_metadata.R"

# Dowload the SRA RUN reads
rule download_sra_reads: 
    input:
        acc=rules.process_metadata.output.csv
    output:
        "{outdir}/{accession}_1.fastq",
        "{outdir}/{accession}_2.fastq"
    params:
        download_folder=OUTDIR,
    threads: 1
    shell:
        """
        fasterq-dump {wildcards.accession} -O {params.download_folder} --threads {threads}
        gzip {wildcards.accession}
        """


rule get_simple_stats:
    input:
        script="workflow/scripts/seqkit_stat_1.sh",
        rawreads=rules.download_sra_reads.output,
    output:
        seqkit1="results/stats1/seqkit_stats.txt",
    threads: 1
    shell:
      "bash {input.script} {input.rawreads}"


rule mothur_mapping_file:
    input:
        stats1=rules.get_simple_stats.output.seqkit1
    output:
        files="results/mothur_mapping_file.tsv",
    threads: 1
    shell:
      "bash {input.script} {input.stats1}"

