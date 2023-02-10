#!/bin/bash

INPUTDIR=data/reads
OUTDIR=results/stats1

mkdir -p "${OUTDIR}"

echo PRGRESS: Getting rawreads simple statistics

# seqkit stat "${INPUTDIR}"/*.fastq.gz >"${OUTDIR}"/seqkit_stats.txt
seqkit stat "${INPUTDIR}"/*.fastq >"${OUTDIR}"/seqkit_stats.txt



# from snakemake.utils import min_version

# min_version("6.10.0")

# # Configuration file containing all user-specified settings
# configfile: "config/config.yaml"

# mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/reads/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

# sraSamples = list(set(glob_wildcards(os.path.join('data/reads/', '{sample}_{sraNum, [12]}.fastq.gz')).sample))


# rule qc_rawreads:
#     input:
#         script="workflow/scripts/seqkit_stat_1.sh",
#         rawreads=expand('data/reads/{sraSamples}_{readNum}.fastq.gz', sraSamples = sraSamples, readNum = config["sraNum"]),
#     output:
#         seqkit1="results/stats1/seqkit_stats.txt",
#     threads: 1
#     shell:
#       "bash {input.script} {input.rawreads}"
