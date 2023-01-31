from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"


rule seqkit:
    input:
        script="workflow/scripts/seqkit.sh",
        rawreads=expand('data/mothur/reads/{mothurSamples}_{readNum}_001.fastq', mothurSamples = mothurSamples, readNum = config["readNum"]),
    output:
        seqkit1="results/qc/seqkit1/seqkit_stats.txt",
    log:
        "logs/seqkit1/seqkit_stats.log",
    threads: 1
    shell:
      "bash {input.script} {input.rawreads}"

