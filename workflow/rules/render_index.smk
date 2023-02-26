from snakemake.utils import min_version

min_version("6.10.0")

# Configuration file containing all user-specified settings
configfile: "config/config.yaml"

<<<<<<< HEAD
# Create GitHub Pages Website
=======

>>>>>>> 82e23e6b2238a556558377ef070f2d22bed304e2
rule deploy_to_github_pages:
    input:
        script="workflow/scripts/render.R",
        rmd="index.Rmd",
<<<<<<< HEAD
        rulegraph="dags/rulegraph.svg",
        tree="images/project_tree.txt",
        html2png="images/smkreport/screenshot.png",
=======
        html2png="images/smkreport/screenshot.png",
        qc="images/qc_hist.svg",
        basicSVG="dags/basic_rulegraph.svg",
        analysisSVG="dags/analysis_rulegraph.svg",
        treeTXT="images/project_tree.txt",
        seqkit1="results/qc/seqkit1/seqkit_stats.txt",
        seqkit2="results/qc/seqkit2/seqkit_stats.txt",
        seqkit3="results/qc/seqkit3/seqkit_stats.txt",
        multiqc1="results/qc/multiqc1/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg",
        multiqc2="results/qc/multiqc2/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg",
        multiqc3="results/qc/multiqc3/multiqc_plots/svg/mqc_fastqc_per_base_sequence_quality_plot_1.svg",
>>>>>>> 82e23e6b2238a556558377ef070f2d22bed304e2
    output:
        doc="index.html",
    shell:
        """
        R -e "library(rmarkdown); render('{input.rmd}')"
        """

