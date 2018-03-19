#!/usr/bin/env sh

######
#
# HX-2018-03-17:
# Created based on a version of
# Brandon Barker
# <brandon dot barker at cornell dot edu>
#
# The following packages are built by the script:
# ATS-Postiats, ATS-Postiats-contrib, and ATS-include
#
######
#
# HX-2018-03-18:
# Here is a typical use of this script (for versions 0.3.10+ of ATS only);
# the first argument to the script is the release to be built:
#
# cd /tmp
# sh ${PATSHOME}/share/SCRIPT/buildRelease.sh 0.3.10
# <
# Upload the following three built packages
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-x.y.z.tgz
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-contrib-x.y.z.tgz
# /tmp/ATS-Postiats/doc/DISTRIB/ATS2-Postiats-include-x.y.z.tgz
# >
# rm -rf /tmp/ATS-Postiats
# rm -rf /tmp/ATS-Postiats-contrib
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

PATSVERSION=$1
if [ -z "$PATSVERSION" ] ;
  then PATSVERSION=$(cat ${PATSHOME}/VERSION)
fi

######

$GIT clone https://github.com/githwxi/ATS-Postiats.git \
  || (cd ATS-Postiats && git pull origin master)

######

$GIT clone https://github.com/githwxi/ATS-Postiats-contrib.git \
  || (cd ATS-Postiats-contrib && git pull origin master)

######

(\
cd $PATSHOME && \
$GIT checkout "tags/v${PATSVERSION}" && \
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
