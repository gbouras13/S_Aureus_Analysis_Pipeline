rule iqtree:
    """Run iqtree."""
    input:
        os.path.join(PANAROO, "core_gene_alignment.aln")
    output:
        os.path.join(IQTREE, "core_gene_alignment.aln"),
        os.path.join(IQTREE, "core_gene_alignment.treefile")
    conda:
        os.path.join('..', 'envs','iqtree.yaml')
    params:
        os.path.join(IQTREE, "core_gene_alignment")
    threads:
        64
    resources:
        mem_mb=BigJobMem
    shell:
        """
        cp {input[0]} {output[0]}
        iqtree -s {output[0]} -pre {params} -nt {threads} -fast -m GTR
        """

rule aggr_iqtree:
    """Aggregate."""
    input:
        os.path.join(IQTREE, "core_gene_alignment.treefile")
    output:
        os.path.join(LOGS, "aggr_iqtree.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem
    shell:
        """
        touch {output[0]}
        """

