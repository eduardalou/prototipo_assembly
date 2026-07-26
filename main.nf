nextflow.enable.dsl=2

include { NANOQ } from './modules/nanoq'

workflow {

    println "Genome Prototype"

    reads = Channel.fromPath("data/ONT-Col-0_test_data.fastq.gz")

    NANOQ(reads)

}