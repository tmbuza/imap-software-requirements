#! /bin/bash
# mothurError.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Set the variables to be used in this script
ERRORFASTA="data/mothur/process/error_analysis/errorinput.fasta"
ERRORCOUNT="data/mothur/process/error_analysis/errorinput.count_table"
MOCKV4="data/mothur/references/zymo.mock.16S.v4.fasta"
MOCKGROUPS=Mock1-Mock2 

MOCKFASTA="data/mothur/process/error_analysis/errorinput.pick.fasta"
MOCKCOUNT="data/mothur/process/error_analysis/errorinput.pick.count_table"


# Other variables
OUTDIR=data/mothur/process

######################
# Run Error Analysis #
######################

# Calculating error rates compared to Zymo reference sequences
echo PROGRESS: Calculating sequencing error rate.

mothur "#get.groups(fasta="${ERRORFASTA}", count="${ERRORCOUNT}", groups="${MOCKGROUPS}")"

mothur "#seq.error(fasta="${MOCKFASTA}", count="${MOCKCOUNT}", reference="${MOCKV4}", aligned=F)"
