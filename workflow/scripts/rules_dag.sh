#!/usr/bin/env bash

set -ev

mkdir -p dags

snakemake -F --rulegraph --snakefile workflow/rules/project_structure.smk | dot -Tsvg > dags/basic_rulegraph.svg
snakemake -F --rulegraph --snakefile workflow/rules/project_structure.smk | dot -Tpng > dags/basic_rulegraph.png

snakemake -F --rulegraph | dot -Tsvg > dags/analysis_rulegraph.svg
snakemake -F --rulegraph | dot -Tpng > dags/analysis_rulegraph.png
