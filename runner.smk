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
BigJobMem = config["BigJobMem"]
BigJobCpu = config["BigJobCpu"]
SmallJobMem = config["SmallJobMem"]


# Parse the samples and read files
include: "rules/samples.smk"
dictReads = parseSamples(CSV)
SAMPLES = list(dictReads.keys())

dictReadsPlasmids = plasmidSamplesFromCsv(CSV)
PLASMIDS_SAMPLES = list(dictReadsPlasmids.keys())

dictReadsNoPlasmids = nonPlasmidSamplesFromCsv(CSV)
NO_PLASMIDS_SAMPLES = list(dictReadsPlasmids.keys())



# Import rules and functions
include: "rules/targets.smk"
include: "rules/annotate_chromosome.smk"
include: "rules/annotate_plasmid.smk"
include: "rules/phispy.smk"
include: "rules/annotate_reference.smk"
include: "rules/snippy.smk"
# won't install for some reason
# include: "rules/panaroo.smk"
include: "rules/iqtree.smk"
include: "rules/pharokka.smk"
include: "rules/isescan.smk"

rule all:
    input:
        TargetFiles
