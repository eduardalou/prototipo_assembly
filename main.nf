nextflow.enable.dsl=2

include { NANOQ } from './modules/nanoq'

include { HIFIASM } from './modules/hifiasm'

include { GFA2FA } from './modules/gfa2fa'

include { FLYE } from './modules/flye'

workflow {

    println "Genome Prototype"

    reads = Channel.fromPath("data/ONT-Col-0_test_data.fastq.gz")

    hifi_reads = Channel.fromPath("data/HiFi-Col-0_test_data.fastq.gz")

    NANOQ(reads)

    gfa = HIFIASM(hifi_reads)

    GFA2FA(gfa)

    flye = FLYE(reads)
}