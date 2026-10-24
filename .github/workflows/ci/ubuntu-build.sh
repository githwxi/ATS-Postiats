#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)
ats_version=${ATSVER:-0.2.12}
export ATSHOME="${HOME}/ats-lang-anairiats-${ats_version}"
export ATSHOMERELOC="ATS-${ats_version}"
export PATSHOME="$repo_root"
export PATSHOMERELOC="${HOME}/ATS-Postiats-contrib"
export PATH="$PATSHOME/bin:$ATSHOME/bin:$PATH"

cd "$repo_root"
git clone https://github.com/githwxi/ATS-Postiats-contrib.git "$PATSHOMERELOC"

./travis-ci/install-ats1.sh "$ats_version"
cd "$ATSHOME"
./configure
make CC=gcc all_ngc

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
