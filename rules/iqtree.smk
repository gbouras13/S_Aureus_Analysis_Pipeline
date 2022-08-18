rule iqtree:
    """Run iqtree."""
    input:
        os.path.join(PANAROO, "core_gene_alignment.aln")
    output:
        os.path.join(PANAROO, "core_tree.treefile")
    conda:
        os.path.join('..', 'envs','iqtree.yaml')
    params:
        os.path.join(PANAROO, "core_tree")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        iqtree -s {input} -pre {params} -nt 8 -fast -m GTR
        """

rule aggr_iqtree:
    """Aggregate."""
    input:
        os.path.join(PANAROO, "core_tree.treefile")
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







iqtree -s core_gene_alignment.aln -pre core_tree -nt 8 -fast -m GTR