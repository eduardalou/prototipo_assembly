process HIFIASM {

    tag "Montando ${reads.simpleName}"

    publishDir "results/hifiasm", mode: "copy"

    cpus 4

    input:
    path reads

    output:
    path "*.bp.p_utg.gfa"

    script:
    """
    prefix="${reads.simpleName}"

    hifiasm \
        -f 0 \
        -t ${task.cpus} \
        -o \$prefix \
        ${reads} \
        2> >(tee \${prefix}.stderr.log >&2)

    if [ -f \${prefix}.ec.fa ]; then
        gzip \${prefix}.ec.fa
    fi

    if [ -f \${prefix}.ovlp.paf ]; then
        gzip \${prefix}.ovlp.paf
    fi
    """
}