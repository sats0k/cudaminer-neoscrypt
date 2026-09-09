#!/bin/bash

make distclean

aclocal && \
autoheader && \
automake --add-missing --gnu --copy && \
autoconf

rm -f config.status

# Warnings
WARN="-Wno-deprecated-gpu-targets"

# Optimisation flags
OPT="-O3 -fomit-frame-pointer -fno-stack-protector"

FLAGS="-march=native -falign-functions=16 \
       -falign-jumps=16 -falign-labels=16"

env \
    CUDA_CFLAGS="-O3 -Xcompiler -Wall -D_FORCE_INLINES $WARN" \
    CFLAGS="$OPT $FLAGS" \
    CXXFLAGS="$OPT $FLAGS" \
    ./configure --with-cuda=/opt/cuda --with-nvml=libnvidia-ml.so

make -j$(nproc)
