def get_input_r1(wildcards):
    return dictReads[wildcards.sample]["R1"]
def get_input_r2(wildcards):
    return dictReads[wildcards.sample]["R2"]


rule snippy:
    """Run snippy."""
    input:
        get_input_r1,
        get_input_r2,
        os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gbk")
    output:
        os.path.join(SNIPPY, "{sample}", "snps.txt"),
        directory(os.path.join(SNIPPY, "{sample}"))
    conda:
        os.path.join('..', 'envs','snippy.yaml')
    params:
        os.path.join(SNIPPY, "{sample}")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        snippy --cpus {threads} --outdir {params} --ref {input[2]} --R1 {input[0]} --R2 {input[1]} 
        """


rule snippy_core:
    input:
        dirs = expand(os.path.join(SNIPPY, "{sample}"), sample = SAMPLES),
        ref = os.path.join(PROKKA,"NCTC_8325","NCTC_8325.gbk")
    output:
        os.path.join(SNIPPY, "core.vcf")
    conda:
        os.path.join('..', 'envs','snippy.yaml')
    params:
        os.path.join(SNIPPY)
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        cd {params[0]}
        snippy-core --prefix core --ref {input.ref} {input.dirs}
        """

rule aggr_snippy:
    """Aggregate."""
    input:
        os.path.join(SNIPPY, "core.vcf")
    output:
        os.path.join(LOGS, "aggr_snippy.txt")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        touch {output[0]}
        """
