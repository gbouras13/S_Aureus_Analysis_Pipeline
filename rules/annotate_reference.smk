rule reference_prokka:
    """Run prokka on reference."""
    input:
        os.path.join(REFERENCE,"NCTC_8325.fasta")
    output:
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gff"),
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.ffn"),
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gbk")
    conda:
        os.path.join('..', 'envs','prokka.yaml')
    params:
        os.path.join(PROKKA, "NCTC_8325")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        prokka --cpus {threads} --genus Staphylococcus --usegenus --outdir {params[0]} --prefix NCTC_8325 {input[0]} --force
        """

rule move_gff_reference:
    input:
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gff")
    output:
        os.path.join(CHROMOSOME_GFFS,"NCTC_8325.gff")
    threads:
        1
    resources:
        mem_mb=SmallJobMem
    shell:
        """
        cp {input[0]} {output[0]} 
        """

rule aggr_prokka_reference:
    """Aggregate."""
    input:
        os.path.join(CHROMOSOME_GFFS,"NCTC_8325.gff ),
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gbk")
    output:
        os.path.join(LOGS, "aggr_prokka_reference.txt")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        touch {output[0]}
        """

