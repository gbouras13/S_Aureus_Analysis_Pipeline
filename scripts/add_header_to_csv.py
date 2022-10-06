#!/usr/bin/env python3

import pandas as pd


def add_header_col_csvs( is_finder_tsv, is_finder_tsv_out, sample):

    is_df = pd.read_csv(is_finder_tsv, delimiter= ',', index_col=False, header=True)

    is_df['sample'] = sample

    is_df.to_csv(is_finder_tsv_out, sep=",")

add_header_col_csvs(snakemake.input.tsv, snakemake.output.tsv,snakemake.wildcards.sample)




