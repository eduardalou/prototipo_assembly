process METRICS {

    tag "Calculando métricas"

    publishDir "results/metrics", mode: "copy"

    input:
    path assembly

    output:
    path "*.tsv"

    script:
    def sample_name = assembly.simpleName

    """
    python - "${assembly}" "${sample_name}" <<'PY'
import sys
import gzip
from Bio import SeqIO

assembly_file = sys.argv[1]
sample = sys.argv[2]

if assembly_file.endswith(".gz"):
    handle = gzip.open(assembly_file, "rt")
else:
    handle = open(assembly_file, "r")

lengths = []
gc_count = 0
total_bases = 0

for record in SeqIO.parse(handle, "fasta"):
    seq = str(record.seq).upper()
    length = len(seq)

    lengths.append(length)

    gc_count += seq.count("G") + seq.count("C")
    total_bases += length

handle.close()

lengths.sort(reverse=True)

total_length = sum(lengths)
num_contigs = len(lengths)
largest_contig = lengths[0] if lengths else 0

def Nx(x):
    target = total_length * x
    cumulative = 0

    for i, length in enumerate(lengths, start=1):
        cumulative += length

        if cumulative >= target:
            return length, i

    return 0, 0

n50, l50 = Nx(0.50)
n90, l90 = Nx(0.90)

gc_percent = (gc_count / total_bases * 100) if total_bases else 0

output = f"{sample}.metrics.tsv"

with open(output, "w") as out:

    out.write(
        "sample\\t"
        "total_length\\t"
        "n_contigs\\t"
        "largest_contig\\t"
        "N50\\t"
        "L50\\t"
        "N90\\t"
        "L90\\t"
        "GC_percent\\n"
    )

    out.write(
        f"{sample}\\t"
        f"{total_length}\\t"
        f"{num_contigs}\\t"
        f"{largest_contig}\\t"
        f"{n50}\\t"
        f"{l50}\\t"
        f"{n90}\\t"
        f"{l90}\\t"
        f"{gc_percent:.2f}\\n"
    )
PY
    """
}