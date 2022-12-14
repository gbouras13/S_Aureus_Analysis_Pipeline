"""
All target output files are declared here
"""

# Preprocessing files
TargetFiles = [
    os.path.join(LOGS, "aggr_bakta_chromosome.txt"),
    os.path.join(LOGS, "aggr_phispy.txt"),
    os.path.join(LOGS, "aggr_prokka_reference.txt"),
    os.path.join(LOGS, "aggr_snippy.txt"),
 #   os.path.join(LOGS, "aggr_panaroo.txt"),
    os.path.join(LOGS, "aggr_iqtree.txt"),
    os.path.join(LOGS, "aggr_isescan.txt"),
    os.path.join(LOGS, "aggr_prophages.txt"),
    os.path.join(LOGS, "aggr_isescan_cluster.txt"),
    os.path.join(LOGS, "aggr_is_summarise.txt")
]



## for the pairwise analysis for phage only

GhaisTargetFiles = [
    os.path.join(LOGS, "aggr_snippy_pair.txt"),
    os.path.join(LOGS, "aggr_nucdiff.txt")
]
