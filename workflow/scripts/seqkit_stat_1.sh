#!/bin/bash

INPUTDIR=data/test
OUTDIR=results/stats1

mkdir -p "${OUTDIR}"

echo PRGRESS: Getting rawreads simple statistics

# seqkit stat "${INPUTDIR}"/*.fastq.gz >"${OUTDIR}"/seqkit_stats.txt
seqkit stat "${INPUTDIR}"/*sub.fastq >"${OUTDIR}"/seqkit_stats.txt
