rule add_sample_to_csv:
    """Collate."""
    input:
        tsv = os.path.join(ISESCAN, "{sample}", "CHROMOSOME_POST_POLISHING", "{sample}.fasta.csv")
    output:
        tsv = os.path.join(ISESCAN_CLEAN_CSVS,"{sample}_isescan.csv"),
    conda:
        os.path.join('..', 'envs','scripts.yaml')
    threads:
        1
    resources:
        mem_mb=1000,
        time=3
    script:
        '../scripts/add_header_to_csv.py'

rule summarise:
    """Collate."""
    input:
        finals = expand(os.path.join(ISESCAN_CLEAN_CSVS,"{sample}_isescan.csv"), sample = SAMPLES),
        cluster = os.path.join(ISESCAN_MMSEQS_ALL, "total_all_samples_cluster.tsv")
    output:
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_final_per_is.csv"),
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_summary.csv")
    conda:
        os.path.join('..', 'envs','scripts.yaml')
    threads:
        1
    resources:
        mem_mb=4000,
        time=5
    script:
        '../scripts/summarise_all_samples.py'

rule summarise_80:
    """Collate."""
    input:
        finals = expand(os.path.join(ISESCAN_CLEAN_CSVS,"{sample}_isescan.csv"), sample = SAMPLES),
        cluster = os.path.join(ISESCAN_MMSEQS_ALL, "total_all_samples_80_cluster.tsv")
    output:
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_final_per_is_80.csv"),
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_summary_80.csv")
    conda:
        os.path.join('..', 'envs','scripts.yaml')
    threads:
        1
    resources:
        mem_mb=4000,
        time=5
    script:
        '../scripts/summarise_all_samples.py'

rule aggr_summarise:
    """Aggregate."""
    input:
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_final_per_is.csv"),
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_summary.csv"),
        os.path.join(ISESCAN_SUMMARY,"total_all_samples_final_per_is_80.csv")
    output:
        os.path.join(LOGS, "aggr_is_summarise.txt")
    threads:
        1
    resources:
        mem_mb=1000,
        time=1
    shell:
        """
        touch {output[0]}
        """