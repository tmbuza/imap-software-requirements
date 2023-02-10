#! /bin/bash
# mothurReferences.sh
# William L. Close
# Schloss Lab
# University of Michigan

##################
# Set Script Env #
##################

# Other variables
OUTDIR=data/mothur/references/ # Directory for storing mothur reference files
LOGS="data/mothur/logs"


####################################
# Preparing Mothur Reference Files #
####################################

echo PROGRESS: Preparing mothur reference files. 

# Making reference output directory
mkdir -p "${OUTDIR}"/ "${OUTDIR}"/tmp/



echo PROGRESS: Preparing SILVA database v4 sequence alignment files. 

# Downloading the prepared SILVA database from the mothur website
# For more inforamtion see https://mothur.org/wiki/silva_reference_files/
curl -L -R -o "${OUTDIR}"/tmp/silva.seed_v138.tgz -z "${OUTDIR}"/tmp/silva.seed_v138.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/silva.seed_v138.tgz

# Decompressing the database
tar -xvzf "${OUTDIR}"/tmp/silva.seed_v138.tgz -C "${OUTDIR}"/tmp/

# Using mothur to pull out bacterial sequences and only keep sequences from the v4 region of the 16S rRNA DNA region
mothur "#set.logfile(name=${LOGS}/silva_seed_align.logfile);
	get.lineage(fasta="${OUTDIR}"/tmp/silva.seed_v138.align, taxonomy="${OUTDIR}"/tmp/silva.seed_v138.tax, taxon=Bacteria);
	
	set.logfile(name=${LOGS}/silva_seed_v4_align.logfile);
	pcr.seqs(fasta=current, start=11894, end=25319, keepdots=F, processors=8)"

# Renaming the final output files
mv "${OUTDIR}"/tmp/silva.seed_v138.pick.align "${OUTDIR}"/silva.seed.align
mv "${OUTDIR}"/tmp/silva.seed_v138.pick.pcr.align "${OUTDIR}"/silva.v4.align

echo PROGRESS: Preparing Silva classifiers. 

mothur "#set.logfile(name=${LOGS}/silva_ng_classifiers.logfile);
	degap.seqs(fasta="${OUTDIR}"/silva.seed.align);
	degap.seqs(fasta="${OUTDIR}"/silva.v4.align)"

echo PROGRESS: Preparing Ribosomal Database Project taxonomy files. 

# Downloading the prepared RDP database from the mothur website
# For more information see https://mothur.org/wiki/rdp_reference_files/
curl -L -R -o "${OUTDIR}"/tmp/trainset16_022016.pds.tgz -z "${OUTDIR}"/tmp/trainset16_022016.pds.tgz https://mothur.s3.us-east-2.amazonaws.com/wiki/trainset16_022016.pds.tgz

# Decompressing the database
tar -xvzf "${OUTDIR}"/tmp/trainset16_022016.pds.tgz -C "${OUTDIR}"/tmp/

# Move the taxonomy files out of the tmp dir
mv "${OUTDIR}"/tmp/trainset16_022016.pds/trainset16_022016* "${OUTDIR}"/



# Cleaning up reference dir
rm -rf "${OUTDIR}"/tmp/
