#!/bin/bash

SCRIPT=`basename $0 .sh`
SCRIPT_DIR=$(realpath $(dirname $0))
# must delete .build directory to trigger a build    
test -d $SCRIPT_DIR/.build && exit 0

CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX:-/tmp/ffmpeg-build}

pushd $SCRIPT_DIR

echo "################### BUILDING $0 ####################"
    
mkdir -p .build || exit 1
cd .build || exit 1

SHELL='/bin/bash -x' ../configure --prefix=$CMAKE_INSTALL_PREFIX --enable-debug=3 \
    --enable-static --disable-shared --pkg-config-flags=--static \
    --disable-optimizations --extra-cflags=-Og --extra-cxxflags=-Og \
    --disable-asm || exit 1
    
make SHELL='/bin/bash -x' || exit 1
make install SHELL='/bin/bash -x' || exit 1

popd
