rule get_rulegraph:
	output:
		"dags/basic_rulegraph.svg",
		"dags/basic_rulegraph.png",
		"dags/analysis_rulegraph.svg",
		"dags/analysis_rulegraph.png",
	shell:
		"bash workflow/scripts/rules_dag.sh"
