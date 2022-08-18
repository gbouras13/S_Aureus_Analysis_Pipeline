"""
Database and output locations for Hecatomb
Ensures consistent variable names and file locations for the pipeline.
"""

import os


### OUTPUT DIRECTORY
if config['Output'] is None:
    OUTPUT = 'Assemblies_Output'
else:
    OUTPUT = config['Output']

# REFERENCE_DIR

REFERENCE = "Reference"

### OUTPUT DIRs
LOGS = os.path.join(OUTPUT, 'LOGS')
TMP = os.path.join(OUTPUT, 'TMP')
PROKKA = os.path.join(TMP, 'PROKKA')
PHISPY = os.path.join(OUTPUT, 'PHISPY')
CHROMOSOME_GFFS = os.path.join(OUTPUT, 'CHROMOSOME_GFFS')
PLASMID_GFFS = os.path.join(OUTPUT, 'PLASMID_GFFS')
SNIPPY = os.path.join(OUTPUT, 'SNIPPY')
PANAROO = os.path.join(OUTPUT, 'PANAROO')


# needs to be created before snippy is run
if not os.path.exists(SNIPPY):
  os.makedirs(SNIPPY)





