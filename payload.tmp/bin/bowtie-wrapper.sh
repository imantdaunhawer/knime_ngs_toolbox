#!/bin/bash

# Wrapper script to bowtie that accepts the same arguments except
# for the first one which has to be the output file.

# Get path to output file and shift it.
OUT=$1
shift

echo "EXECUTING bowtie -S $* >${OUT}"
bowtie -S $* >${OUT}
