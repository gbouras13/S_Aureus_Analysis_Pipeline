rule panaroo:
    """Run panaroo."""
    input:
        gffs = expand(os.path.join(CHROMOSOME_GFFS,"{sample}.gff"), sample = SAMPLES)
    output:
        os.path.join(PANAROO, "gene_presence_absence.Rtab"),
        os.path.join(PANAROO, "core_gene_alignment.aln")
    conda:
        os.path.join('..', 'envs','panaroo.yaml')
    params:
        out_dir = PANAROO
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        panaroo -i {input.gffs} -o {params.out_dir} --clean-mode strict -a core  --core_threshold 0.98 -t {threads}
        """

rule aggr_panaroo:
    """Aggregate."""
    input:
        os.path.join(PANAROO, "gene_presence_absence.Rtab"),
        os.path.join(PANAROO, "core_gene_alignment.aln")
    output:
        os.path.join(LOGS, "aggr_panaroo.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem
    shell:
        """
        touch {output[0]}
        """

