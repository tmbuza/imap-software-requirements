rule basic_software:
    input:
        rmd="software.Rmd",
        ide="images/RStudioIDE.png"
    output:
        html="software.html"
    shell:
        """
        R -e "rmarkdown::render('{input.rmd}')"
        """
