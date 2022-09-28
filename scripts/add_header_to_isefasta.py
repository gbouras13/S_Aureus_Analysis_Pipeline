#!/usr/bin/env python3

from Bio import SeqIO

def add_header( isescan_fasta, out_file, sample):
    # read gff        

    with open(out_file, 'w') as fa:
        for dna_record in SeqIO.parse(isescan_fasta, "fasta"):
            dna_record.id = sample + "_" + dna_record.id 
            SeqIO.write(dna_record, fa, 'fasta')
          
 
add_header(snakemake.input.fasta, snakemake.output.fasta, snakemake.wildcards.sample)




