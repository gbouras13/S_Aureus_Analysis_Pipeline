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
CHROMOSOME_GFFS = os.path.join(OUTPUT, 'CHROMOSOME_GFFS')
CHROMOSOME_GBKS = os.path.join(OUTPUT, 'CHROMOSOME_GBKS')
PLASMID_GFFS = os.path.join(OUTPUT, 'PLASMID_GFFS')
SNIPPY = os.path.join(OUTPUT, 'SNIPPY')
PANAROO = os.path.join(OUTPUT, 'PANAROO')
IQTREE = os.path.join(OUTPUT, 'IQTREE')

# ISE Dirs
ISESCAN_PLAS = os.path.join(OUTPUT, 'ISESCAN_PLAS')
ISESCAN = os.path.join(OUTPUT, 'ISESCAN')
# ISE Cluster dirs
ISESCAN_CLEAN_FASTAS = os.path.join(OUTPUT, 'ISESCAN_CLEAN_FASTAS')
ISESCAN_CLEAN_TSVS = os.path.join(OUTPUT, 'ISESCAN_CLEAN_TSVS')
ISESCAN_CLUSTERING = os.path.join(OUTPUT, 'ISESCAN_CLUSTERING')
ISESCAN_MMSEQS = os.path.join(ISESCAN_CLUSTERING, 'ISESCAN_MMSEQS')
ISESCAN_MMSEQS_ALL = os.path.join(ISESCAN_CLUSTERING, 'ISESCAN_MMSEQS_ALL')
ISESCAN_SUMMARY = os.path.join(OUTPUT, 'ISESCAN_SUMMARY')




# Prophages 
PHISPY = os.path.join(OUTPUT, 'PHISPY')
PROPHAGES = os.path.join(OUTPUT, 'PROPHAGES')
PHAROKKA = os.path.join(OUTPUT, 'PHAROKKA')

# ghais dirs
SNIPPY_PAIR = os.path.join(OUTPUT, 'SNIPPY_PAIR')
NUCDIFF = os.path.join(OUTPUT, 'NUCDIFF')



# needs to be created before snippy is run
if not os.path.exists(SNIPPY):
  os.makedirs(SNIPPY)

if not os.path.exists(SNIPPY_PAIR):
  os.makedirs(SNIPPY_PAIR)

if not os.path.exists(NUCDIFF):
  os.makedirs(NUCDIFF)




