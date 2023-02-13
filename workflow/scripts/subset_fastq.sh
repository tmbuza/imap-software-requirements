#!/bin/bash

INPUTDIR="data/reads"
OUTDIR="data/test"

mkdir -p "${OUTDIR}"

echo PRGRESS: Resizing fastq file for testing

for i in {6..9};
  do
    cat "${INPUTDIR}"/SRR745070$i\_1.fastq \
    | seqkit sample -p 0.01 \
    | seqkit shuffle -o "${OUTDIR}"/SRR745070$i\_1_sub.fastq \
    | cat "${INPUTDIR}"/SRR745070$i\_2.fastq \
    | seqkit sample -p 0.01 \
    | seqkit shuffle -o "${OUTDIR}"/SRR745070$i\_2_sub.fastq;
  done

