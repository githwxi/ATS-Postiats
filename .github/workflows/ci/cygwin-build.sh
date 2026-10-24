#!/usr/bin/env bash

set -euo pipefail

workspace=$(cygpath -u "$GITHUB_WORKSPACE")
cd "$workspace"

ats_version=0.2.12
export ATSHOME="$workspace/ats-lang-anairiats-${ats_version}"
export ATSHOMERELOC="ATS-${ats_version}"
export PATSHOME="$workspace"
export PATSHOMERELOC="$HOME/ATS-Postiats-contrib"
export PATH="$PATSHOME/bin:$ATSHOME/bin:$PATH"

git clone https://github.com/githwxi/ATS-Postiats-contrib.git "$PATSHOMERELOC"
tar -xzf "xassets/ATS1/ats-lang-anairiats-${ats_version}.tgz" -C "$workspace"

cd "$ATSHOME"
./configure
# ATS1 emits C with implicit declarations; keep GCC's diagnostic as a warning.
make CC=gcc ATS_PROOFCHECK=-Wno-error=implicit-function-declaration all

cd "$PATSHOME"
make -f Makefile_devl CC=gcc all

make -C src CBOOTgmp
make -C src/CBOOT/prelude
make -C src/CBOOT/libc
make -C src/CBOOT/libats
make -C doc/DISTRIB -f Makefile atspackaging
make -C doc/DISTRIB -f Makefile atspacktarzvcf_gmp

if ! make -C doc -f Makefile_test testall > testall_doc.log 2>&1; then
  tail -100 testall_doc.log
  exit 1
fi
tail -100 testall_doc.log

cp "$ATSHOME/config.h" .
make -C src cleanall
make -C src/CBOOT/libc
make -C src/CBOOT/libats
make -C src/CBOOT/prelude
make -C utils/libatsopt build
cp -f utils/libatsopt/BUILD/libatsopt.a "$ATSHOME/ccomp/lib"
make -C utils/libatsynmark build
cp -f utils/libatsynmark/BUILD/libatsynmark.a "$ATSHOME/ccomp/lib"
make -C utils/atsynmark

make -C doc/BOOK/ATS2TUTORIAL
make -C doc/BOOK/INT2PROGINATS
