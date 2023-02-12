from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


# Master rule for controlling workflow.
rule all:
    input:
        "results/stats1/seqkit_stats.txt",


rule get_simple_stats:
    input:
        script="workflow/scripts/seqkit_stat_1.sh",
    output:
        seqkit1="results/stats1/seqkit_stats.txt",
    threads: 1
    shell:
      "bash {input.script}"

