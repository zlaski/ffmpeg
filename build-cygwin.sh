#!/bin/bash

SCRIPT=`basename $0 .sh`
SCRIPT_DIR=$(realpath $(dirname $0))
pushd $SCRIPT_DIR

echo "################### BUILDING $0 ####################"
    
rm -rf .build || exit 1
mkdir -p .build || exit 1
cd .build || exit 1

SHELL='/bin/bash -x' ../configure --prefix=$CMAKE_INSTALL_PREFIX || exit 1
    
make SHELL='/bin/bash -x' || exit 1
make install SHELL='/bin/bash -x' || exit 1

popd
