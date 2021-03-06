#!/bin/bash

# Wrapper script to paired-end-end BWA that does some linking magic.
#
# USAGE: bwa-sampe-wrapper.sh OUT.sam REF.{fa,fasta} INDEX.bwaidx           \
#                             READS.{fa,fasta,fq,fastq}                     \
#                             [RIGHT.{fa,fasta,fq,fastq}] <other arguments>
#
# TODO(holtgrew): RIGHT does not work yet.

# Include helper functions
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}"/wrapper_utils.sh

# ---------------------------------------------------------------------------
# Cleanup at Exit
# ---------------------------------------------------------------------------

# Register trap to remove temporary files.
trap rm_tmp_dir SIGINT SIGTERM EXIT HUP INT QUIT TERM

# ---------------------------------------------------------------------------
# Parameter Handling
# ---------------------------------------------------------------------------

# Get path to output, reference, index, and reads.
OUT=$1
shift
REF=$1
shift
INDEX=$1
shift
READS=$1
shift
RIGHT=$1
shift

# ---------------------------------------------------------------------------
# Link Magic
# ---------------------------------------------------------------------------

# Create temporary directory.
mk_tmp_dir

# Create reference and index links.
bwa_link_ref

# ---------------------------------------------------------------------------
# Actual Call
# ---------------------------------------------------------------------------

# Execute bwa aln and bwasamse but redirect output.
echo "EXECUTING bwa aln $* ${THIS_TMP_DIR}/ref.fa ${READS} >${THIS_TMP_DIR}/left.sai"
bwa aln $* ${THIS_TMP_DIR}/ref.fa ${READS} >${THIS_TMP_DIR}/left.sai
echo "EXECUTING bwa aln $* ${THIS_TMP_DIR}/ref.fa ${RIGHT} >${THIS_TMP_DIR}/right.sai"
bwa aln $* ${THIS_TMP_DIR}/ref.fa ${RIGHT} >${THIS_TMP_DIR}/right.sai
echo "EXECUTING bwa sampe $* ${THIS_TMP_DIR}/ref.fa ${THIS_TMP_DIR}/left.sai ${READS} ${RIGHT} >${OUT}"
bwa sampe $* ${THIS_TMP_DIR}/ref.fa ${THIS_TMP_DIR}/left.sai ${THIS_TMP_DIR}/right.sai ${READS} ${RIGHT} >${OUT}
