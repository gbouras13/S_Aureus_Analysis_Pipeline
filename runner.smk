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
dictReads = parseSamples(CSV)
SAMPLES = list(dictReads.keys())
#print(SAMPLES)

# get the samples that have plasmids, or not as dicts https://stackoverflow.com/questions/16099557/splitting-dict-by-value-of-one-of-the-keys
print(dictReads)
No_Plasmids_dict = [ { key : dictReads[key][idx] for key in dictReads.keys() }  for idx, x in enumerate(dictReads["Plasmids"]) if x == "None" ]
NO_PLASMIDS_SAMPLES = list(No_Plasmids_dict.keys())
Plasmids_dict = [ { key : dictReads[key][idx] for key in dictReads.keys() }  for idx, x in enumerate(dictReads["Plasmids"]) if x != "None" ]
PLASMIDS_SAMPLES = list(Plasmids_dict.keys())

# Import rules and functions
include: "rules/targets.smk"
include: "rules/annotate_chromosome.smk"
include: "rules/phispy.smk"

rule all:
    input:
        TargetFiles
