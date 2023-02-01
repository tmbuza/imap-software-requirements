from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

rule interactive_report:
	input:
	output:
		"report/report.html",
	shell:
		"""
		snakemake -c3 --report report.zip
		unzip report.zip
		rm report.zip
		"""