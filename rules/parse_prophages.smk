rule parse_plasmids:
    input:
        os.path.join(INPUT, "{sample}.fasta")
    output:
        os.path.join(PROPHAGES,"{sample}_touch.csv")
    threads:
        1
    params:
        PROPHAGES
    conda:
        os.path.join('..', 'envs','scripts.yaml')
    resources:
        mem_mb=SmallJobMem, 
        time=10
    script:
        '../scripts/parse_prophages.py'

rule aggr_plasdb:
    input:
        expand(os.path.join(PROPHAGES,"{sample}_touch.csv"), sample = SAMPLES),
    output:
        os.path.join(LOGS, "aggr_prophages.txt")
    threads:
        1
    resources:
        mem_mb=SmallJobMem, 
        time=5
    shell:
        """
        touch {output[0]}
        """
