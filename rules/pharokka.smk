rule pharokka:
    """Run phispy."""
    input:
        os.path.join(PHISPY,"{sample}", "phage.fasta")
    output:
        os.path.join(PHAROKKA,"{sample}", "pharokka.gff")
    conda:
        os.path.join('..', 'envs','pharokka.yaml')
    params:
        os.path.join(PHAROKKA,"{sample}"),
        PHAROKKA_DB
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        pharokka.py -i {input} -o {params[0]} -d {params[1]} -t {threads}
        """

rule aggr_pharokka:
    """Aggregate."""
    input:
        expand(os.path.join(PHAROKKA,"{sample}", "pharokka.gff"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_pharokka.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem
    shell:
        """
        touch {output[0]}
        """

