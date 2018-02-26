#!/bin/bash
cd "$1"
cp -r src src2
mkdir -p build
mkdir -p bin
rm -r build
mv src2 build
cd build
find . -name "*.o" -type f -print0 | xargs -0 -n 1 -I "{}" rm "{}"
find . -name "*.c" -type f -print0 | xargs -0  -n 1 -I "{}" gcc "{}" -c  -o "{}.o"
find . -name "*.c" -type f -print0 | xargs -0 -n 1 -I "{}" rm "{}"
cd ..
find "build" -name "*.o" -type f -print0 | xargs -0 gcc -o "bin/$2"

