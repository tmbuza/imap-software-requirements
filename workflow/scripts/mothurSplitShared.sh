#! /bin/bash

# otutable_by_group.sh


MOCKGROUPS="Mock1-Mock2" # List of mock groups in raw data dir separated by '-'
CONTROLGROUPS="Water1-Water2-Water3" # List of control groups in raw data dir separated by '-'
COMBINEDGROUPS=$(echo "${MOCKGROUPS}"-"${CONTROLGROUPS}") # Combines the list of mock and control groups into a single string separated by '-'

OUTDIR="data/mothur/process"
LOGS="data/mothur/logs"


# Sample shared file
echo PROGRESS: Creating sample shared file.

# Removing all mock and control groups from shared file leaving only samples
mothur "#set.logfile(name=${LOGS}/otutable_by_group.logfile);
remove.groups(shared="${OUTDIR}"/final.shared, groups="${COMBINEDGROUPS}", outputdir=${OUTDIR})"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/sample.final.shared


# Mock shared file
echo PROGRESS: Creating mock shared file.

# Removing non-mock groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/final.shared, groups="${MOCKGROUPS}")"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/mock.final.shared

# Control shared file
echo PROGRESS: Creating control shared file.

# Removing any non-control groups from shared file
mothur "#get.groups(shared="${OUTDIR}"/final.shared, groups="${CONTROLGROUPS}")"
mv "${OUTDIR}"/final.0.03.pick.shared "${OUTDIR}"/control.final.shared
