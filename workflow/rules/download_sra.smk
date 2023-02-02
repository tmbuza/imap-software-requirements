# # Snakefile
# # William L. Close
# # Schloss Lab
# # University of Michigan

# # Modifications TMB

# # Snakemake file for running mothur 16S pipeline

# # Configuration file containing all user-specified settings
# configfile: "config/config.yaml"

# # Function for aggregating list of raw sequencing files.
# mothurSamples = list(set(glob_wildcards(os.path.join('data/mothur/raw/', '{sample}_{readNum, R[12]}_001.fastq.gz')).sample))

# # Master rule for controlling workflow.
# rule all:
# 	input:
# 		"data/mothur/process/error_analysis/errorinput.pick.error.summary",
# 		"data/mothur/process/final.shared",
# 		"data/mothur/process/sample.final.shared",
# 		"data/mothur/process/error_analysis/errorinput.fasta",
# 		"data/mothur/process/error_analysis/errorinput.count_table",
# 		# "data/mothur/process/sample.final.count.summary",
# 		"data/mothur/process/sample.final.0.03.subsample.shared",
# 		"data/mothur/process/sample.final.groups.rarefaction",
# 		# "data/mothur/process/sample.final.sharedsobs.0.03.lt.dist",
# 		# "data/mothur/process/sample.final.thetayc.0.03.lt.dist",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.dist",
# 		# "data/mothur/process/sample.final.sharedsobs.0.03.lt.ave.dist",
# 		# "data/mothur/process/sample.final.sharedsobs.0.03.lt.std.dist",
# 		# "data/mothur/process/sample.final.thetayc.0.03.lt.ave.dist",
# 		# "data/mothur/process/sample.final.thetayc.0.03.lt.std.dist",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.dist",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.std.dist",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.tre",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.pcoa.axes",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.pcoa.loadings",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.nmds.iters",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.nmds.stress",
# 		# "data/mothur/process/sample.final.braycurtis.0.03.lt.ave.nmds.axes",
# 		"project_tree.txt",
# 		# "dags/rulegraph.svg",
# 		# "dags/rulegraph.png",
# 		# "dags/dag.svg",
# 		# "dags/dag.png",
# 		"report.html",
# 		"index.html"


# # Get directory tree
# rule get_project_tree_txt:
# 	output:
# 		tree="project_tree.txt"
# 	shell:
# 		"tree -d . >{output}"


# rule get_rulegraph:
# 	output:
# 		"dags/rulegraph.svg",
# 		"dags/rulegraph.png",
# 		"dags/dag.svg",
# 		"dags/dag.png"
# 	shell:
# 		"bash workflow/scripts/rules_dag.sh"

# rule interactive_report:
# 	output:
# 		"report.html",
# 	shell:
# 		"""
# 		snakemake --report report.html
# 		"""

# rule github_page_index:
#     input:
#         script="workflow/scripts/render.R",
#         rmd="index.Rmd",
#         rulegraph="dags/rulegraph.svg",
		
#     output:
#         doc="index.html",
#     shell:
#         """
#         R -e "library(rmarkdown); render('{input.rmd}')"
#         """
# # Get rawread data.
# rule getReadData:
# 	input:
# 		script="workflow/scripts/getReads.sh",
# 	output:
# 		reads="data/mothur/reads/{mothurSamples}_{readNum}_001.fastq.gz"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"


# # Downloading and formatting SILVA and RDP reference databases. The v4 region is extracted from 
# # SILVA database for use as reference alignment.
# rule get16SReferences:
# 	input:
# 		script="workflow/scripts/mothurReferences.sh"
# 	output:
# 		silvaV4="data/mothur/references/silva.v4.align",
# 		rdpFasta="data/mothur/references/trainset16_022016.pds.fasta",
# 		rdpTax="data/mothur/references/trainset16_022016.pds.tax"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"


# # Downloading the Zymo mock sequence files and extracting v4 region for error estimation.
# rule get16SMock:
# 	input:
# 		script="workflow/scripts/mothurMock.sh",
# 		silvaV4=rules.get16SReferences.output.silvaV4
# 	output:
# 		mockV4="data/mothur/references/zymo.mock.16S.v4.fasta"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"


# # Making mothur-based sample mapping file.
# rule makeMappingFile:
# 	input:
# 		script="workflow/scripts/makeFile.sh",
# 		reads=expand(rules.getReadData.output,
# 			mothurSamples = mothurSamples, readNum = config["readNum"]),
# 	output:
# 		files="data/mothur/process/test.files",
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script}"

# # Generating master OTU shared file.
# rule make16SShared:
# 	input:
# 		script="workflow/scripts/mothurShared.sh",
# 		files=rules.makeMappingFile.output,
# 		refs=rules.get16SReferences.output,
# 		reads=expand(rules.getReadData.output, mothurSamples = mothurSamples, readNum = config["readNum"]),
# 	output:
# 		shared="data/mothur/process/final.shared",
# 		taxonomy="data/mothur/process/final.taxonomy",
# 		errorFasta="data/mothur/process/error_analysis/errorinput.fasta",
# 		errorCount="data/mothur/process/error_analysis/errorinput.count_table"
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script} data/mothur/raw/ {input.refs}"


# # Splitting master shared file into individual shared file for: i) samples, ii) controls, and iii) mocks.
# # This is used for optimal subsampling during downstream steps.
# rule split16SShared:
# 	input:
# 		script="workflow/scripts/mothurSplitShared.sh",
# 		shared=rules.make16SShared.output.shared
# 	output:
# 		shared=expand("data/mothur/process/{group}.final.shared", group = config["mothurGroups"])
# 	params:
# 		mockGroups='-'.join(config["mothurMock"]), # Concatenates all mock group names with hyphens
# 		controlGroups='-'.join(config["mothurControl"]) # Concatenates all control group names with hyphens
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script} {params.mockGroups} {params.controlGroups}"


# # Estimate sequencing error rate based on mock sequences.
# rule calc16SError:
# 	input:
# 		script="workflow/scripts/mothurError.sh",
# 		errorFasta=rules.make16SShared.output.errorFasta,
# 		errorCount=rules.make16SShared.output.errorCount,
# 		mockV4=rules.get16SMock.output.mockV4
# 	output:
# 		summary="data/mothur/process/error_analysis/errorinput.pick.error.summary"
# 	params:
# 		mockGroups='-'.join(config["mothurMock"]) # Concatenates all mock group names with hyphens
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script} {input.errorFasta} {input.errorCount} {input.mockV4} {params.mockGroups}"


# rule alpha_beta_diversity:
# 	input:
# 		script="workflow/scripts/mothurAlphaBeta.sh",
# 		# shared="data/mothur/process/sample.final.shared",
# 		shared=expand("data/mothur/process/{group}.final.shared", group = "sample"),
# 	output:
# 		subsample="data/mothur/process/sample.final.0.03.subsample.shared",
# 		rarefy="data/mothur/process/sample.final.groups.rarefaction",
# 	conda:
# 		"envs/mothur.yaml"
# 	shell:
# 		"bash {input.script} {input.shared}"


##################################################################
#
# Download SRA
#
##################################################################

import csv
import pandas as pd

SRA_MAPPING = pd.read_csv('config/samples.csv')
SAMPLES = SRA_MAPPING['sample_name'].tolist()

READSDIR="reads" 
OUTDIR=READSDIR+"/"

rule all:
    input:
        expand("{outdir}{samples}_1.fastq", outdir=OUTDIR, samples=SAMPLES),
        expand("{outdir}{samples}_2.fastq", outdir=OUTDIR, samples=SAMPLES)


rule download_srareads: 
    output:
        "%s{samples}_1.fastq" % OUTDIR,
        "%s{samples}_2.fastq" % OUTDIR
    params:
        download_folder = READSDIR
    shell:
        "fasterq-dump {wildcards.samples} -O {params.download_folder}"
 