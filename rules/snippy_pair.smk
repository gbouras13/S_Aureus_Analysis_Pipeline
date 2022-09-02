def get_input_r1(wildcards):
    return dictReads[wildcards.sample]["T1_R1"]
def get_input_r2(wildcards):
    return dictReads[wildcards.sample]["T1_R2"]
def get_input_gbk(wildcards):
    return dictReads[wildcards.sample]["T0_gbk"]


rule snippy:
    """Run snippy."""
    input:
        get_input_r1,
        get_input_r2,
        get_input_gbk
    output:
        os.path.join(SNIPPY_PAIR, "{sample}", "snps.txt"),
        directory(os.path.join(SNIPPY_PAIR, "{sample}"))
    conda:
        os.path.join('..', 'envs','snippy.yaml')
    params:
        os.path.join(SNIPPY_PAIR, "{sample}")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        # https://github.com/tseemann/snippy/issues/508
        # add snpEff=5.0 to yaml
        snippy --cpus {threads} --outdir {params} --ref {input[2]} --R1 {input[0]} --R2 {input[1]}  --force
        """

rule aggr_snippy:
    """Aggregate."""
    input:
        expand(os.path.join(SNIPPY_PAIR, "{sample}", "snps.txt"), sample = SAMPLES)
    output:
        os.path.join(LOGS, "aggr_snippy_pair.txt")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        touch {output[0]}
        """
