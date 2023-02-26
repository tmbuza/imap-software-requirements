# Get dot rule graphs
rule dot_rules_graph:
	output:
<<<<<<< HEAD
		"dags/rulegraph.svg",
		"dags/rulegraph.png",
=======
		"dags/basic_rulegraph.svg",
		"dags/basic_rulegraph.png",
		"dags/analysis_rulegraph.svg",
		"dags/analysis_rulegraph.png",
>>>>>>> 82e23e6b2238a556558377ef070f2d22bed304e2
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