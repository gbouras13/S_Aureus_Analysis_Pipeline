def get_chromosome(wildcards):
    return dictReads[wildcards.sample]["Chromosome"]

rule prokka_chromosome:
    """Run prokka."""
    input:
        get_chromosome
    output:
        os.path.join(PROKKA,"{sample}","{sample}.gff"),
        os.path.join(PROKKA,"{sample}","{sample}.ffn"),
        os.path.join(PROKKA,"{sample}","{sample}.gbk")
    conda:
        os.path.join('..', 'envs','prokka.yaml')
    params:
        os.path.join(PROKKA, "{sample}")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        prokka --cpus {threads} --genus Staphylococcus --usegenus --outdir {params[0]} --prefix {wildcards.sample} {input[0]} --force
        """

rule move_gff_chromosome:
    input:
        os.path.join(PROKKA,"{sample}","{sample}.gff")
    output:
        os.path.join(CHROMOSOME_GFFS,"{sample}.gff")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        cp {input[0]} {output[0]} 
        """

rule aggr_prokka_chromosome:
    """Aggregate."""
    input:
        expand(os.path.join(CHROMOSOME_GFFS,"{sample}.gff" ), sample = SAMPLES),
        expand(os.path.join(PROKKA,"{sample}","{sample}.gbk"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_prokka_chromosome.txt")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        touch {output[0]}
        """
