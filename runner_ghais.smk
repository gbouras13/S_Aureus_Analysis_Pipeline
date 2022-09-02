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
BigJobMem = config["BigJobMem"]
BigJobCpu = config["BigJobCpu"]
SmallJobMem = config["SmallJobMem"]


# Parse the samples and read files
include: "rules/samples.smk"
dictReads = parseGess(CSV)
SAMPLES = list(dictReads.keys())



# Import rules and functions
include: "rules/targets.smk"
include: "rules/snippy_pair.smk"

rule all:
    input:
        GhaisTargetFiles
