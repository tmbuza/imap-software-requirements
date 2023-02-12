#!/bin/bash

INPUTDIR=data/reads
OUTDIR=results/stats1

mkdir -p "${OUTDIR}"

echo PRGRESS: Getting rawreads simple statistics

# seqkit stat "${INPUTDIR}"/*.fastq.gz >"${OUTDIR}"/seqkit_stats.txt
seqkit stat "${INPUTDIR}"/*.fastq >"${OUTDIR}"/seqkit_stats.txt
