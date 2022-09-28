rule add_sample_to_fasta_header:
    """Run mmseqs."""
    input:
        fasta = os.path.join(ISESCAN, "{sample}", "CHROMOSOME", "{sample}.fasta.is.fna")
    output:
        fasta = os.path.join(ISESCAN_CLEAN_FASTAS, "{sample}.fasta")
    conda:
        os.path.join('..', 'envs','scripts.yaml')
    threads:
        1
    resources:
        mem_mb=4000,
        time=5
    script:
        '../scripts/add_header_to_isefasta.py'


rule cluster_each_seq:
    """Run mmseqs on each sample."""
    input:
        os.path.join(ISESCAN_CLEAN_FASTAS, "{sample}.fasta")
    output:
        os.path.join(ISESCAN_MMSEQS, "{sample}_all_seqs.fasta"),
        os.path.join(ISESCAN_MMSEQS, "{sample}_cluster.tsv")
    conda:
        os.path.join('..', 'envs','cluster.yaml')
    params:
        os.path.join(ISESCAN_MMSEQS,  "{sample}"),
        os.path.join(ISESCAN_MMSEQS,  "{sample}_mmseqs2")
    threads:
        2
    resources:
        mem_mb=8000,
        time=20
    shell:
        """
        mmseqs easy-cluster {input[0]} {params[0]} {params[1]} --min-seq-id 0.95 -c 0.95
        """

rule concat_fastas:
    """concate all fastas"""
    input:
        expand(os.path.join(ISESCAN_CLEAN_FASTAS, "{sample}.fasta"), sample = SAMPLES)
    output:
        os.path.join(ISESCAN_CLEAN_FASTAS,"all_samples_isescan.fasta" )
    threads:
        1
    resources:
        mem_mb=4000,
        time=10
    shell:
        """
        cat {input} > {output}
        """

rule cluster_all_seqs:
    """Run on all."""
    input:
        os.path.join(ISESCAN_CLEAN_FASTAS,"all_samples_isescan.fasta" )
    output:
        os.path.join(ISESCAN_MMSEQS_ALL, "total_all_samples_all_seqs.fasta"),
        os.path.join(ISESCAN_MMSEQS_ALL, "total_all_samples_cluster.tsv")
    conda:
        os.path.join('..', 'envs','cluster.yaml')
    params:
        os.path.join(ISESCAN_MMSEQS_ALL,  "total_all_samples"),
        os.path.join(ISESCAN_MMSEQS_ALL,  "total_all_samples_tmp")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem,
        time=120
    shell:
        """
        mmseqs easy-cluster {input[0]} {params[0]} {params[1]} --min-seq-id 0.95 -c 0.95
        """

#### aggregation rule

rule aggr_cluster:
    """Aggregate."""
    input:
        expand(os.path.join(ISESCAN_MMSEQS, "{sample}_cluster.tsv"), sample = SAMPLES),
        os.path.join(ISESCAN_MMSEQS_ALL, "total_all_samples_all_seqs.fasta")
    output:
        os.path.join(LOGS, "aggr_isescan_cluster.txt")
    threads:
        1
    resources:
        mem_mb=4000,
        time=3
    shell:
        """
        touch {output[0]}
        """







