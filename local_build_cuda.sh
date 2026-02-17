#!/bin/bash

 eval "$(conda shell.bash hook)"
 conda activate llamacpp

pip install -r requirements.txt

CMAKE_BIN=/usr/bin/cmake
CTEST_BIN=/usr/bin/ctest

CMAKE_MAKE_PROGRAM=~/.local/bin/ninja
#CMAKE_C_COMPILER=/usr/bin/clang-16
#CMAKE_CXX_COMPILER=/usr/bin/clang++-16
CMAKE_C_COMPILER=/usr/bin/gcc-9
CMAKE_CXX_COMPILER=/usr/bin/g++-9

# Adjust GNU version to cope with NVCC limit of gcc12
sudo ln -sf /usr/bin/gcc-9 /usr/bin/gcc
sudo ln -sf /usr/bin/g++-9 /usr/bin/g++

 rm -rf build

 $CMAKE_BIN -DLLAMA_CURL=OFF -DGGML_CUDA=ON -DGGML_CUDA_FA_ALL_QUANTS=ON -DGGML_CUDA_FORCE_MMQ=ON -DLLAMA_BUILD_TESTS=ON -DLLAMA_BUILD_EXAMPLES=ON \
   -DCMAKE_C_COMPILER=$CMAKE_C_COMPILER \
   -DCMAKE_CXX_COMPILER=$CMAKE_CXX_COMPILER \
   -B ./build -S . "-DCMAKE_TOOLCHAIN_FILE=~/Documents/Gitrepo-My/vcpkg/scripts/buildsystems/vcpkg.cmake" \
   -G Ninja

$CMAKE_BIN --build ./build --config Release

# Turn gcc back to 13
sudo ln -sf /usr/bin/gcc-13 /usr/bin/gcc
sudo ln -sf /usr/bin/g++-13 /usr/bin/g++
