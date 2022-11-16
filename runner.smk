"""
The snakefile that runs the pipeline.
Manual launch example:
"""

import os

### DEFAULT CONFIG FILE

configfile: os.path.join(  'config', 'config.yaml')


### DIRECTORIES

include: "rules/directories.smk"

# get if needed
CSV = config['csv']
OUTPUT = config['Output']
COREALN = config['Corealn']
BAKTA_DB = config['BaktaDB']
BigJobMem = config["BigJobMem"]
BigJobCpu = config["BigJobCpu"]
SmallJobMem = config["SmallJobMem"]


# Parse the samples and read files
include: "rules/samples.smk"
dictReads = parseSamples(CSV)
SAMPLES = list(dictReads.keys())

# gets the samples with plasmids for isescan of the plasmids
dictReadsPlasmids = plasmidSamplesFromCsv(CSV)
PLASMIDS_SAMPLES = list(dictReadsPlasmids.keys())


# Import rules and functions
include: "rules/targets.smk"
# annotate chromosomes
include: "rules/annotate_chromosome.smk"
include: "rules/annotate_reference.smk"
# run phispy to predict  prophages then parse them to get 1 fasta per phage
include: "rules/phispy.smk"
include: "rules/parse_prophages.smk"
# snippy vs the reference
include: "rules/snippy.smk"

# remove panaroo - run manually as it wont run on hpc for some reason
# won't install for some reason
include: "rules/panaroo.smk"
# try ppangolin?

# iqtree based on panaroo alignment of core genome 
include: "rules/iqtree.smk"

# run isescan to look for IS elements and cluster them
include: "rules/isescan.smk"
include: "rules/isescan_cluster.smk"
include: "rules/summarise_is_cluster.smk"

rule all:
    input:
        TargetFiles
