#!/usr/bin/env sh

set -e
set -x

cmake -B build
cmake --build build
./build/src/hello
