process GFA2FA {

    tag "Convertendo ${gfa.simpleName}"

    publishDir "results/gfa2fa", mode: "copy"

    input:
    path gfa

    output:
    path "*.fa.gz"

    script:
    """
    outfile=\$(basename ${gfa} .gfa).fa.gz

    awk '/^S/{print ">"\$2; print \$3}' ${gfa} \
        | gzip > \$outfile
    """
}