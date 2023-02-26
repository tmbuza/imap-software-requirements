#!/usr/bin/env bash

set -ev

mkdir -p dags

# snakemake -F --rulegraph --snakefile workflow/rules/project_structure.smk | dot -Tsvg > dags/rulegraph.svg
# snakemake -F --rulegraph --snakefile workflow/rules/project_structure.smk | dot -Tpng > dags/rulegraph.png

snakemake -F --rulegraph | dot -Tsvg > dags/rulegraph.svg
snakemake -F --rulegraph | dot -Tpng > dags/rulegraph.png
