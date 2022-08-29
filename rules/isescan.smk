def get_chromosome(wildcards):
    return dictReads[wildcards.sample]["Chromosome"]

def get_plasmid(wildcards):
    return dictReadsPlasmids[wildcards.plasmids_sample]["Plasmids"]

rule isescan_chrom:
    """Run isescan."""
    input:
        get_chromosome
    output:
        os.path.join(ISESCAN, "{sample}", "{sample}.fasta.csv")
    conda:
        os.path.join('..', 'envs','isescan.yaml')
    params:
        os.path.join(ISESCAN, "{sample}")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        isescan.py --seqfile {input[0]} --output results --nthread 2
        """

rule isescan_plas:
    """Run isescan on plasmids."""
    input:
        get_chromosome
    output:
        os.path.join(ISESCAN_PLAS, "{plasmids_sample}", "{plasmids_sample}.fasta.csv")
    conda:
        os.path.join('..', 'envs','isescan.yaml')
    params:
        os.path.join(ISESCAN_PLAS, "{plasmids_sample}")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        isescan.py --seqfile {input[0]} --output results --nthread 2
        """

rule aggr_isescan:
    """Aggregate."""
    input:
        expand(os.path.join(ISESCAN_PLAS, "{plasmids_sample}", "{plasmids_sample}.fasta.csv"), plasmids_sample = PLASMIDS_SAMPLES),
        expand(os.path.join(ISESCAN, "{sample}", "{sample}.fasta.csv"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_isescan.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem
    shell:
        """
        touch {output[0]}
        """

