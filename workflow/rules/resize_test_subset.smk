from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule all:
    input:
        expand("{testdir}/{accession}_1_sub.fastq", testdir=TESTDIR, accession=ACCESSIONS),
        expand("{testdir}/{accession}_2_sub.fastq", testdir=TESTDIR, accession=ACCESSIONS),
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
        """

# Subset a test data
rule resize_test_subset:
    input:
        expand("{outdir}/{accession}_1.fastq", outdir=OUTDIR, accession=ACCESSIONS),
        expand("{outdir}/{accession}_2.fastq", outdir=OUTDIR, accession=ACCESSIONS),
    output:
        "{testdir}/{accession}_1_sub.fastq",
        "{testdir}/{accession}_2_sub.fastq",
    threads: 1
    shell:
        """
        bash workflow/scripts/resize_test_subset.sh
        """