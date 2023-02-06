
rule get_tidy_metadata:
    output:
        csv="data/metadata/metadata.csv"
    script:
        "scripts/get_tidy_metadata.R"
        

rule plot_variable_freq:
    input:
        csv=rules.get_tidy_metadata.output.csv
    output:
        png="images/variable_freq.png",
    script:
        "scripts/plot_var_freq.R"


rule explore_read_size:
    input:
        csv=rules.get_tidy_metadata.output.csv
    output:
        readsize="data/metadata/metadata.csv"
    script:
        "scripts/explore_read_size.R"
      
  
rule get_sample_gps:
    input:
        csv=rules.get_tidy_metadata.output.csv
    output:
        map="images/sample_gps.png"
    script:
        "scripts/get_sample_gps.R"
