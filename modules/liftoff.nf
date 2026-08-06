process LIFTOFF {

    tag "Anotando ${assembly.simpleName}"

    publishDir "results/liftoff", mode: "copy"

    cpus 4

    input:
    path assembly
    path reference
    path gff

    output:
    path "assembly.gff3"

    script:
    """
    if [[ ${assembly} == *.gz ]]; then
        zcat ${assembly} > assembly.fa
    else
        ln -s ${assembly} assembly.fa
    fi

    if [[ ${reference} == *.gz ]]; then
        zcat ${reference} > reference.fa
    else
        ln -s ${reference} reference.fa
    fi

    liftoff \
        assembly.fa \
        reference.fa \
        -g ${gff} \
        -o liftoff.gff3 \
        -p ${task.cpus}
    """
}