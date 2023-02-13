#!/bin/bash

# Creating basic variables
MAPPING="resources/metadata"
READSDIR="resources/reads"
TESTDIR="resources/test"
MOTHURREFS="resources/references"

###############################
echo PROGRESS: "Preparing resouces for Bioinformatics (IMAP-PART 2)"
###############################

mkdir -p "${MAPPING}" "${READSDIR}" "${TESTDIR}" "${MOTHURREFS}"

cp data/metadata/metadata.csv "${MAPPING}"/
cp data/metadata/mothur_mapping.tsv "${MAPPING}"/
cp data/metadata/mothur_design.tsv "${MAPPING}"/
cp data/reads/*.fastq "${READSDIR}"/
cp data/test/*_sub.fastq "${TESTDIR}"/
cp data/mothur/references/* "${MOTHURREFS}"/
