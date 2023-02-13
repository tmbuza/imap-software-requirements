from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Resources for downstream analyses


rule get_bioinfo_resources:
    shell:
        """
        bash workflow/scripts/get_bioinfo_resources.sh
        """