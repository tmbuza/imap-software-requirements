from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Master rule for controlling workflow.
rule all:
	input:
		"index.html",

# Get dot rule graphs
rule dot_rule_graph:
	output:
		"dags/rulegraph.svg",
		"dags/rulegraph.png",
	shell:
		"bash workflow/scripts/rules_dag.sh"

# Get project tree
rule project_tree:
    output:
        tree="images/project_tree.txt"
    shell:
        """
        bash workflow/scripts/tree.sh
        """

# Get smk html report
rule snakemake_html_report:
	output:
		"images/smkreport/screenshot.png"
	shell:
		"bash workflow/scripts/smk_html_report.sh"

rule deploy_to_github_pages:
    input:
        script="workflow/scripts/render.R",
        rmd="index.Rmd",
        rulegraph="dags/rulegraph.svg",
        tree="images/project_tree.txt",
        html2png="images/smkreport/screenshot.png",
    output:
        doc="index.html",
    shell:
        """
        R -e "library(rmarkdown); render('{input.rmd}')"
        """

