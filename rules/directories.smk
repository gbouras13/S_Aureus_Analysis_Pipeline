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
# pharokka db
PHAROKKA_DB="/hpcfs/users/a1667917/pharokka_db"

### OUTPUT DIRs
LOGS = os.path.join(OUTPUT, 'LOGS')
TMP = os.path.join(OUTPUT, 'TMP')
PROKKA = os.path.join(TMP, 'PROKKA')
PHISPY = os.path.join(OUTPUT, 'PHISPY')
CHROMOSOME_GFFS = os.path.join(OUTPUT, 'CHROMOSOME_GFFS')
CHROMOSOME_GBKS = os.path.join(OUTPUT, 'CHROMOSOME_GBKS')
PLASMID_GFFS = os.path.join(OUTPUT, 'PLASMID_GFFS')
SNIPPY = os.path.join(OUTPUT, 'SNIPPY')
PANAROO = os.path.join(OUTPUT, 'PANAROO')
PHAROKKA = os.path.join(OUTPUT, 'PHAROKKA')
IQTREE = os.path.join(OUTPUT, 'IQTREE')
ISESCAN_PLAS = os.path.join(OUTPUT, 'ISESCAN_PLAS')
ISESCAN = os.path.join(OUTPUT, 'ISESCAN')

# needs to be created before snippy is run
if not os.path.exists(SNIPPY):
  os.makedirs(SNIPPY)





