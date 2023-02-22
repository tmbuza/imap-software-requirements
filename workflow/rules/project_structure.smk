from snakemake.utils import min_version

min_version("6.10.0")

rule targets:
    input:
        "dags/analysis_rulegraph.svg",
        "dags/analysis_rulegraph.png",
        "dags/basic_rulegraph.svg",
        "dags/basic_rulegraph.png",
        "images/smkreport/screenshot.png",
        "images/project_tree.txt",

# Get dot rule graphs
rule basic_rulegraph:
	output:
		"dags/analysis_rulegraph.svg",
		"dags/analysis_rulegraph.png",
		"dags/basic_rulegraph.svg",
		"dags/basic_rulegraph.png",
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
