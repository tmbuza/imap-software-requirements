#!/bin/bash

# Generate interactive html report
snakemake --report report.html

# snakemake -c3 --report report.zip
# unzip report.zip
# rm report.zip