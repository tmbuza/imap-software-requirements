rule download_srareads: 
        input:
                acc=rules.get_sra_metadata.output.csv
        output:
                "{outdir}/{accession}_1.fastq",
                "{outdir}/{accession}_2.fastq"
        params:
                download_folder=OUTDIR,
                tempfolder=TEMPDIR
        threads: 1
        shell:
                "fasterq-dump {wildcards.accession} -O {params.download_folder} --temp {params.tempfolder} --threads {threads}"