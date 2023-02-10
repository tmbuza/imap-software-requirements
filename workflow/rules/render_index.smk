from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

# Create a shareabke html report
rule github_page_index:
    input:
        script="workflow/scripts/render.R",
        rmd="index.Rmd",
        rulegraph="dags/rulegraph.svg",
        dag="images/variable_freq.svg",
        map="images/sample_gps.png",
        html2png="images/smkreport/screenshot.png",
        tree="images/project_tree.txt",
        asce="results/read_size_asce.csv",
        desc="results/read_size_desc.csv",
    output:
        doc="index.html",
    shell:
        """
        R -e "library(rmarkdown); render('{input.rmd}')"
        """

