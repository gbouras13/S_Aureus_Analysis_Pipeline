#!/usr/bin/env python3

import pandas as pd
import numpy as np

def read_is_csv(is_csv):
    is_df = pd.read_csv(is_csv, delimiter= ',', index_col=False, header=0)
    return is_df




def collate_tsvs( is_finder_csv_list, cluster_df, count_out_per_sample, counts_matrix):

    csvs = []
    l =is_finder_csv_list

    for a in l:
        tmp_csv = read_is_csv(a)
        # remove first row (from the file)
        # tmp_tsv = tmp_tsv.iloc[1: , :]
        csvs.append(tmp_csv)

    # make into combined dataframe
    total_df = pd.concat(csvs,  ignore_index=True)

    # to match mmseqs

    # blank if not + or - 
    total_df.loc[~total_df['strand'].isin(['+', '-']), "strand"] = ""

    total_df['locus_tag'] = total_df['sample'] + "_contig_1_polypolish_" + total_df['isBegin'].astype(str) + "_" + total_df['isEnd'].astype(str) + "_" + total_df['strand']

    # read in cluster from mmseqs tsv file
    colnames_mmseqs=['representative_fasta', 'locus_tag']
    mmseqs = pd.read_csv(cluster_df, delimiter= '\t', index_col=False, header=None, names=colnames_mmseqs) 
    
    total_df['locus_tag']=total_df['locus_tag'].astype(str)
    mmseqs['locus_tag']=mmseqs['locus_tag'].astype(str)
    
    print(total_df)
    print(mmseqs)

    merged_df = pd.merge(total_df, mmseqs, on='locus_tag')
    
    print(merged_df)


    merged_df['count'] = merged_df.groupby(['sample','representative_fasta'])['representative_fasta'].transform('count')


    # final summaries
    # count per sample
    count_df = merged_df[["sample", "representative_fasta","family", "cluster", "count"]].drop_duplicates()
    count_df.to_csv(count_out_per_sample, sep=",", index=False)

    # count matrix total per sample
    count_df_p = merged_df[["sample", "representative_fasta", "count"]].drop_duplicates()
    count_df_p = count_df_p.pivot(index="sample", columns="representative_fasta", values="count").fillna(0)
    count_df_p['Total Insertion Sequences'] = np.sum(count_df_p,axis=1)
    # need to keep index for sample
    count_df_p.to_csv(counts_matrix, sep=",")


collate_tsvs(snakemake.input.finals, snakemake.input.cluster, snakemake.output[0],snakemake.output[1])




