#!/bin/bash

set -e

if [ -z "$PREFIX" ]; then
  PREFIX="$CONDA_PREFIX"
fi

# conda build will copy everything over, including build directories.
# Don't let this pollute the build!
rm -rf build || true

mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX="$PREFIX" -DCMAKE_PREFIX_PATH="$PREFIX" -DCMAKE_BUILD_TYPE=Release $CONDA_CMAKE_ARGS ..
# Work around https://github.com/zdevito/ATen/issues/92
make install -j20 || make install -j20
