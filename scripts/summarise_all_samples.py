#!/usr/bin/env python3

import pandas as pd
import numpy as np

def read_is_tsv(is_tsv):
    is_df = pd.read_csv(is_tsv, delimiter= '\t', index_col=False, header=0)
    return is_df




def collate_tsvs( is_finder_tsv_list, cluster_df, count_out_per_sample, counts_matrix):

    tsvs = []
    l =is_finder_tsv_list

    for a in l:
        tmp_tsv = read_is_tsv(a)
        # remove first row (from the file)
        # tmp_tsv = tmp_tsv.iloc[1: , :]
        tsvs.append(tmp_tsv)

    # make into combined dataframe
    total_df = pd.concat(tsvs,  ignore_index=True)

    # to match mmseqs
    total_df['locus_tag'] = total_df['sample'] + "_contig_1_polypolish_" + total_df['isBegin'].astype(str) + "_" + total_df['isEnd'].astype(str) + "_" + total_df['strand'].astype(str)

    # read in cluster from mmseqs
    colnames_mmseqs=['representative_fasta', 'locus_tag']
    mmseqs = pd.read_csv(cluster_df, delimiter= '\t', index_col=False, header=None, names=colnames_mmseqs) 

    merged_df = pd.merge(tsvs, mmseqs)

    merged_df['count'] = merged_df.groupby(['sample','representative_fasta'])['representative_fasta'].transform('count')


    # final summaries
    # count per sample
    count_df = merged_df[["sample", "representative_fasta","family", "cluster", "count"]].drop_duplicates()
    count_df.to_csv(count_out_per_sample, sep=",", index=False)

    # count matrix total per sample
    count_df_p = merged_df[["sample", "representative_fasta", "count"]].drop_duplicates()
    count_df_p = count_df_p.pivot(index="sample", columns="representative_fasta", values="count").fillna(0)
    count_df_p['Total Insertion Sequences'] = np.sum(count_df_p,axis=1)
    count_df_p.to_csv(counts_matrix, sep=",")


collate_tsvs(snakemake.input.finals, snakemake.input.cluster, snakemake.output[0],snakemake.output[1])




