#!/bin/bash
export BUILD_DIR=build
if [ ! -b "$BUILD_DIR" ]; then
  mkdir $BUILD_DIR
fi
cd $BUILD_DIR
cmake -G "Unix Makefiles" \
      -DCMAKE_BUILD_TYPE=Debug \
      -DVCPKG_APPLOCAL_DEPS=ON \
      -DVCPKG_TARGET_TRIPLET=x64-linux \
      -DCMAKE_TOOLCHAIN_FILE=/mnt/d/my_vcpkg/scripts/buildsystems/vcpkg.cmake \
      ..