#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: "broadinstitute/gatk:4.1.3.0"

inputs:
  # REQUIRED ARGS

  InputFile:
    type: File
    inputBinding:
      prefix: "-I"
    secondaryFiles:
      - .bai

  Variant:
    type: File
    inputBinding:
      prefix: "-V"

  Reference:
    type: File
    inputBinding:
      prefix: "-R"
    secondaryFiles:
      - ^.dict
      - .fai

  Output:
    type: string
    default: "annotated.vcf"
    inputBinding:
      prefix: "-O"
      valueFrom: "annotated.vcf"

  # OPTIONAL ARGS
  TensorType:
    type: string?
    inputBinding:
      prefix: "-tensor-type"

  Architecture:
    type: string?
    inputBinding:
      prefix: "-architecture"

  Weights:
    type: File?
    inputBinding:
      prefix: "-weights"

baseCommand: ["/gatk/gatk"]

arguments:
  - valueFrom: "CNNScoreVariants"
    position: -1

outputs:
  filteredVCF:
    type: File
    format: edam:format_3016  # VCF
    outputBinding:
      glob: "annotated.vcf"

$namespaces:
  edam: https://edamontology.org/
$schemas:
  - https://edamontology.org/EDAM_1.18.owl
