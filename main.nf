nextflow.enable.dsl=2

include { NANOQ } from './modules/nanoq'
include { HIFIASM } from './modules/hifiasm'
include { GFA2FA } from './modules/gfa2fa'
include { FLYE } from './modules/flye'
include { RAGTAG_PATCH } from './modules/ragtag_patch'
include { LIFTOFF } from './modules/liftoff'

workflow {

    println "Genome Prototype"

    reads = Channel.fromPath("data/ONT-Col-0_test_data.fastq.gz")

    hifi_reads = Channel.fromPath("data/HiFi-Col-0_test_data.fastq.gz")

    reference = Channel.fromPath("data/Col-CEN_v1.2.Chr1_5MB-7MB.fasta.gz")

    annotation = Channel.fromPath("data/Col-CEN_v1.2_genes_araport11.Chr1_5MB-7MB.gff3.gz")

    NANOQ(reads)

    gfa = HIFIASM(hifi_reads)

    fasta = GFA2FA(gfa)

    flye = FLYE(reads)

    patched = RAGTAG_PATCH(flye, fasta)

    LIFTOFF(patched, reference, annotation)
}