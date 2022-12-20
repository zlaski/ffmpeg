#!/bin/bash -x

SCRIPT=`basename $0 .sh`
SCRIPT_DIR=$(realpath $(dirname $0))
pushd $SCRIPT_DIR

echo CMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX
echo BUILD_SHARED_LIBS=$BUILD_SHARED_LIBS

rm -rf .build || exit 1
mkdir -p .build || exit 1
cd .build || exit 1

../configure --prefix=$CMAKE_INSTALL_PREFIX || exit 1
make || exit 1
make install || exit 1

popd
