#!/usr/bin/env sh


cd ${PATSHOME} 

make -f Makefile_devl CC=${GCC} all
# make GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${GCC} all
# make C3NSTRINTKND=intknd -f Makefile_devl CC=${CLANG} all
# make C3NSTRINTKND=intknd GCFLAG=-D_ATS_GCATS -f Makefile_devl CC=${CLANG} all

make -C ${PATSHOME}/src CBOOT
make -C ${PATSHOME}/src/CBOOT/prelude
make -C ${PATSHOME}/src/CBOOT/libc
make -C ${PATSHOME}/src/CBOOT/libats
make -C ${PATSHOME}/doc/DISTRIB atspackaging
make -C ${PATSHOME}/doc/DISTRIB atspacktarzvcf
make -C ${PATSHOME}/doc/DISTRIB cleanall
# make -C ${PATSHOME}/doc/DISTRIB atscontribing
# make -C ${PATSHOME}/doc/DISTRIB atscntrbtarzvcf
# make -C ${PATSHOME}/doc/DISTRIB cleanall