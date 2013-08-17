#!/bin/bash

# Wrapper script to bwa index that automatically adds the suffix ".bwaidx"
# to the generated files.  This is currently required to make GKN pick up the
# index files.
#
# USAGE: bwa-index-wrapper IN.fa OUT <other arguments as usual>

# Get path to input.
IN=$1
shift

# Get path to output.
OUT=${1}
shift

# Execute bwa bwasw but redirect output.
bwa index -p ${OUT} ${IN} $*
for x in ${OUT}.*; do
	mv ${x} ${x}.bwaidx
done
