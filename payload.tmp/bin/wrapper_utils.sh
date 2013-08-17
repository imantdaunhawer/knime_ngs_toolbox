# A library of helper functions for writing wrappers.

# ---------------------------------------------------------------------------
# Function mk_tmp_dir()
#
# Create a temporary directory and store its name in ${THIS_TMP_DIR}
# ---------------------------------------------------------------------------

# Create a temporary directory.
function mk_tmp_dir()
{
	THIS_TMP_DIR=$(tempfile)
	rm -f ${THIS_TMP_DIR}
	mkdir -p ${THIS_TMP_DIR}
}

# ---------------------------------------------------------------------------
# Function rm_tmp_dir()
#
# Delete the directory ${THIS_TMP_DIR} and all files within.
# ---------------------------------------------------------------------------

# Remove the temporary file again.
function rm_tmp_dir()
{
	rm -rf ${THIS_TMP_DIR}
}

# ---------------------------------------------------------------------------
# Function bwa_link_ref()
#
# Helper for BWA wrappers.
#
# (1) Link the reference ${REF} to ${THIS_TMP_DIR}/ref.fa
# (2) Link all BWA index files to ${THIS_TMP_DIR}/ref.<ext>
# ---------------------------------------------------------------------------

function bwa_link_ref()
{
	# Link reference.
	echo "EXECUTING ln -s ${REF} ${THIS_TMP_DIR}/ref.fa"
	ln -s ${REF} ${THIS_TMP_DIR}/ref.fa

	# Link index files.
	for x in ${INDEX}*; do
		bn=$(basename $x)
		bni=$(basename ${INDEX})
		# Extract original index suffix after moving and appending prefix.
		suffix=$(echo ${bn} | sed "s/${bni}//g" | sed "s/\.bwaidx\$//g")
		echo "EXECUTING ln -s ${x} ${THIS_TMP_DIR}/ref.fa${suffix}"
		ln -s ${x} ${THIS_TMP_DIR}/ref.fa${suffix}
	done

	echo "EXECUTING ls -lh ${THIS_TMP_DIR}"
	ls -lh ${THIS_TMP_DIR}
}
