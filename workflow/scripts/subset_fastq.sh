#!/bin/bash

INPUTDIR="data/reads"
OUTDIR="data/reads/test"

mkdir -p "${OUTDIR}"

echo PRGRESS: Resizing fastq file for testing

for i in {77..81};
  do
    cat "${INPUTDIR}"/SRR102452$i\_1.fastq \
    | seqkit sample -p 0.01 \
    | seqkit shuffle -o "${OUTDIR}"/SRR102452$i\_1_sub.fastq \
    | cat "${INPUTDIR}"/SRR102452$i\_2.fastq \
    | seqkit sample -p 0.01 \
    | seqkit shuffle -o "${OUTDIR}"/SRR102452$i\_2_sub.fastq;
  done

