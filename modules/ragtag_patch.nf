process RAGTAG_PATCH {

    tag "Combinando ${target.simpleName} com ${query.simpleName}"

    publishDir "results/ragtag", mode: "copy"

    cpus 4

    input:
    path target
    path query

    output:
    
    path "ragtag_output/*.patch.fasta"
    
    script:
    """
    if [[ ${target} == *.gz ]]; then
         zcat ${target} > target.fa
    else
        ln -s ${target} target.fa
    fi

    if [[ ${query} == *.gz ]]; then
        zcat ${query} > query.fa
    else
        ln -s ${query} query.fa
    fi

    ragtag.py patch \
        target.fa \
        query.fa \
        -o ragtag_output \
        -t ${task.cpus}
    """
}