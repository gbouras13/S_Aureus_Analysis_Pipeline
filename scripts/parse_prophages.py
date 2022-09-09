#!/usr/bin/env python3

import pandas as pd
import os
from Bio import SeqIO


def parse_plasmids(input_fasta, out_dir, output_touch, sample):    

    for dna_record in SeqIO.parse(input_fasta, "fasta"):
        contig_file = os.path.join(out_dir, sample + "_" + dna_record.id + ".fasta")
        with open(contig_file, 'w') as fa:
            SeqIO.write(dna_record, fa, 'fasta')
    # write regardless if the file is empty for the snakemake rule
    touch(output_touch)
        

# function to touch create a file 
# https://stackoverflow.com/questions/12654772/create-empty-file-using-python
def touch(path):
    with open(path, 'a'):
        os.utime(path, None)
                
parse_plasmids(snakemake.input[0],snakemake.params[0], snakemake.output[0], snakemake.wildcards.sample)



        
