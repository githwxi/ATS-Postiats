#!/usr/bin/env sh

cp ${ATSHOME}/config.h .
# make -C src cleanall
# make -C src/CBOOT/prelude
# make -C src/CBOOT/libc
# make -C src/CBOOT/libats
make -C utils/libatsopt
cp utils/libatsopt/libatsopt.a ${ATSHOME}/ccomp/lib
make -C utils/libatsynmark
cp utils/libatsynmark/libatsynmark.a ${ATSHOME}/ccomp/lib
make -C utils/atsynmark
# make -C utils/atstagging
# make -C utils/packeditall