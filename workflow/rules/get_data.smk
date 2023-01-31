from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule get_silva_alignements:
	input:
		script="workflow/scripts/mothur_silva.sh"
	output:
		align="{dbdir}/silva.seed.align",
	conda:
		"envs/mothur.yaml"
	shell:
		"bash {input.script}"



rule get_sra:
    output:
        "sra/{accession}_1.fastq",
        "sra/{accession}_2.fastq",
    log:
        "logs/get-sra/{accession}.log",
    wrapper:
        "0.77.0/bio/sra-tools/fasterq-dump"
