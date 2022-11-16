rule reference_bakta:
    """Run prokka on reference."""
    input:
        os.path.join(REFERENCE,"NCTC_8325.fasta")
    output:
        os.path.join(BAKTA,"NCTC_8325","NCTC_8325.gff3"),
        os.path.join(BAKTA,"NCTC_8325","NCTC_8325.ffn"),
        os.path.join(BAKTA,"NCTC_8325","NCTC_8325.gbff")
    conda:
        os.path.join('..', 'envs','bakta.yaml')
    params:
        BAKTA_DB,
        os.path.join(BAKTA, "NCTC_8325")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        bakta --db {params[0]} --verbose --output {params[1]} --prefix NCTC_8325  --locus-tag NCTC_8325 --threads {threads} {input[0]} 
        """

rule move_gff_reference:
    input:
        os.path.join(BAKTA,"NCTC_8325","NCTC_8325.gff3")
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
        os.path.join(CHROMOSOME_GFFS,"NCTC_8325.gff" ),
        os.path.join(BAKTA,"NCTC_8325","NCTC_8325.gbff")
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

