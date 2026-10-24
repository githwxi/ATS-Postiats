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
make CC=gcc all

cd "$PATSHOME"
make -f codegen/Makefile_atslib
make -f Makefile_devl src_depend
make -f Makefile_devl CC=gcc all
