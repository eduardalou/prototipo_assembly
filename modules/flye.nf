process FLYE {

    tag "Montando ${reads.simpleName}"

    publishDir "results/flye", mode: "copy"

    cpus 4

    input:
    path reads

    output:
    path "*.assembly.fasta.gz"

    script:
    """
    prefix="${reads.simpleName}"

    flye \
        --nano-hq \
        ${reads} \
        --out-dir . \
        --threads ${task.cpus} \
        --genome-size 2000000

    gzip -c assembly.fasta > \${prefix}.assembly.fasta.gz
    gzip -c assembly_graph.gfa > \${prefix}.assembly_graph.gfa.gz
    gzip -c assembly_graph.gv > \${prefix}.assembly_graph.gv.gz

    mv assembly_info.txt \${prefix}.assembly_info.txt
    mv flye.log \${prefix}.flye.log
    mv params.json \${prefix}.params.json
    """
}