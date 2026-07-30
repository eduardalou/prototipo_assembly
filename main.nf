nextflow.enable.dsl=2

include { NANOQ } from './modules/nanoq'

include { HIFIASM } from './modules/hifiasm'

workflow {

    println "Genome Prototype"

    reads = Channel.fromPath("data/ONT-Col-0_test_data.fastq.gz")

    hifi_reads = Channel.fromPath("data/HiFi-Col-0_test_data.fastq.gz")

    NANOQ(reads)

    HIFIASM(hifi_reads)
}