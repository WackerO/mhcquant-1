// Import generic module functions
include { initOptions; saveFiles } from './functions'

params.options = [:]

process RESOLVE_FOUND_NEOEPITOPES {
    publishDir "${params.outdir}/"
    echo true

    input:
    tuple val(id), val(Sample), file(mztab), file(neoepitopes)

    output:
    tuple val("$id"), val("$Sample"), file("${Sample}_found_neoepitopes_class_1.csv")
    
    when:
    params.include_proteins_from_vcf & params.predict_class_1

    script:
    """
        resolve_neoepitopes.py -n ${neoepitopes} -m ${mztab} -f csv -o ${Sample}_found_neoepitopes_class_1
    """
}