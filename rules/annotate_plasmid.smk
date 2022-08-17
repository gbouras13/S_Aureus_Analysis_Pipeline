def get_plasmid(wildcards):
    return Plasmids_dict[wildcards.plasmids_sample]["Plasmid"]

rule prokka_plasmid:
    """Run prokka."""
    input:
        get_plasmid
    output:
        os.path.join(PROKKA,"{plasmids_sample}_plasmid","{plasmids_sample}.gff"),
        os.path.join(PROKKA,"{plasmids_sample}_plasmid","{plasmids_sample}.ffn"),
        os.path.join(PROKKA,"{plasmids_sample}_plasmid","{plasmids_sample}.gbk")
    conda:
        os.path.join('..', 'envs','prokka.yaml')
    params:
        os.path.join(PROKKA, "{plasmids_sample}_plasmid")
    threads:
        BigJobCpu
    resources:
        mem_mb=BigJobMem
    shell:
        """
        prokka --cpus {threads} --genus Staphylococcus --usegenus --outdir {params[0]} --prefix {wildcards.plasmids_sample} {input[0]} --force
        """

rule move_gff:
    input:
        os.path.join(PROKKA,"{plasmids_sample}_plasmid","{plasmids_sample}.gff")
    output:
        os.path.join(PLASMID_GFFS,"{plasmids_sample}.gff")
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
        expand(os.path.join(PLASMID_GFFS,"{plasmids_sample}.gff"), plasmids_sample = PLASMIDS_SAMPLES)
    output:
        os.path.join(LOGS, "aggr_prokka_plasmid.txt")
    threads:
        1
    resources:
        mem_mb=BigJobMem
    shell:
        """
        touch {output[0]}
        """
