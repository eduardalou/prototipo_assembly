process NANOQ {

    tag "Analisando ${reads.simpleName}"

    publishDir "results/nanoq", mode: "copy"

    input:
    path reads

    output:
    path "${reads.simpleName}_report.json"
    path "${reads.simpleName}_stats.json"

    script:
    """
    nanoq \
        -i $reads \
        -j \
        -r ${reads.simpleName}_report.json \
        -s -H -vvv \
        > ${reads.simpleName}_stats.json
    """
}