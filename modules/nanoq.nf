process NANOQ {

    tag "Analisando ${reads.simpleName}"

    input:
    path reads

    output:
    path "*_report.json"
    path "*_stats.json"

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