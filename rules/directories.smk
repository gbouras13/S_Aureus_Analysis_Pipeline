"""
Database and output locations for Hecatomb
Ensures consistent variable names and file locations for the pipeline.
"""


### OUTPUT DIRECTORY
if config['Output'] is None:
    OUTPUT = 'Assemblies_Output'
else:
    OUTPUT = config['Output']


### OUTPUT DIRs
LOGS = os.path.join(OUTPUT, 'LOGS')
TMP = os.path.join(OUTPUT, 'TMP')
PROKKA = os.path.join(TMP, 'PROKKA')
PHISPY = os.path.join(OUTPUT, 'PHISPY')
CHROMOSOME_GFFS = os.path.join(OUTPUT, 'CHROMOSOME_GFFS')
PLASMID_GFFS = os.path.join(OUTPUT, 'PLASMID_GFFS')
ROARY = os.path.join(OUTPUT, 'CHROMOSOME_GFFS')









