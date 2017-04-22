#!/usr/bin/env sh


make -f Makefile_devl CC=${CC} all
# make GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${GCC} all
# make C3NSTRINTKND=intknd -f Makefile_devl CC=${CLANG} all
# make C3NSTRINTKND=intknd GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${CLANG} all

make -C src CBOOT
make -C src/CBOOT/prelude
make -C src/CBOOT/libc
make -C src/CBOOT/libats
make -C doc/DISTRIB atspackaging
make -C doc/DISTRIB atspacktarzvcf
make -C doc/DISTRIB cleanall
# make -C ${PATSHOME}/doc/DISTRIB atscontribing
# make -C ${PATSHOME}/doc/DISTRIB atscntrbtarzvcf
# make -C ${PATSHOME}/doc/DISTRIB cleanall