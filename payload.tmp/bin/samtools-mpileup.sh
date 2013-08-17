#!/bin/bash

# Wrapper script to samtools mpileup that accepts the same arguments except
# for the first one which has to be the output file.

# Get path to output file and shift it.
OUT=$1
shift

# Execute mpileup and then use filter to variant sites using bcftools.
samtools mpileup -u $* | bcftools view -bvcg - >${OUT}
