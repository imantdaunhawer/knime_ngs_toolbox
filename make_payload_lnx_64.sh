#!/bin/bash
DIR=$(pwd)
pushd payload.tmp
zip -x '*~' -r ${DIR}/workflow_plugin_dir/payload/binaries_lnx_64.zip *
popd
