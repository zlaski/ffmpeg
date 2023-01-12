#!/bin/bash

SCRIPT=`basename $0 .sh`
SCRIPT_DIR=$(realpath $(dirname $0))
# must delete .build directory to trigger a build    
test -d $SCRIPT_DIR/.build && exit 0

pushd $SCRIPT_DIR

echo "################### BUILDING $0 ####################"
    
mkdir -p .build || exit 1
cd .build || exit 1

SHELL='/bin/bash -x' ../configure --prefix=$CMAKE_INSTALL_PREFIX --enable-debug=gdb \
    --disable-doc --enable-static --disable-shared --pkg-config-flags=--static || exit 1
    
make SHELL='/bin/bash -x' || exit 1
make install SHELL='/bin/bash -x' || exit 1

popd
