#!/usr/bin/env sh

######
#
# HX-2018-03-17:
# Created based on a version of
# Brandon Barker
#
# The following three packages are
# to be built by the script
#
# ATS-Postiats, ATS-Postiats-contrib, and ATS-include
#
######

PWD=$(pwd)

######

GIT=$(which git)
if [ -x "$GIT" ] ; 
  then echo "$GIT found.";
  else echo "$GIT not found." exit 1;
fi

######

ATSCC=$(which atscc)
if [ -x "$ATSCC" ] ; 
  then echo "$ATSCC found.";
  else echo "$ATSCC not found." exit 1;
fi

######

PATSHOME=${PWD}/ATS-Postiats
PATSCONTRIB=${PWD}/ATS-Postiats-contrib

######

$GIT clone https://github.com/githwxi/ATS-Postiats.git

######

$GIT clone https://github.com/githwxi/ATS-Postiats-contrib.git

######

(\
cd $PATSHOME && \
make -f Makefile_devl && \
make -C src -f Makefile CBOOT  && \
(cp ./bin/*_env.sh.in ./doc/DISTRIB/ATS-Postiats/bin/.) && \
(cd ./doc/DISTRIB/ATS-Postiats && sh ./autogen.sh && ./configure) && \
make -C src/CBOOT/libc -f Makefile && \
make -C src/CBOOT/libats -f Makefile && \
make -C src/CBOOT/prelude -f Makefile && \
make -C doc/DISTRIB -f Makefile atspackaging && \
make -C doc/DISTRIB -f Makefile atspacktarzvcf && \
make -C doc/DISTRIB -f Makefile atscontribing && \
make -C doc/DISTRIB -f Makefile atscontribtarzvcf && \
make -C doc/DISTRIB -f Makefile_inclats tarzvcf \
)

######

ls -al $PATSHOME/doc/DISTRIB/ATS2-*.tgz

###### end of [buildRelease.sh] ######
