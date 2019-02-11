#!/usr/bin/env sh

######
#
# HX-2018-12-19:
# This version is FROZEN.
# Please make no changes!!!
#
######
#
# HX-2018-03-17:
# Created based on a version by
# Brandon Barker
# <brandon dot barker at cornell dot edu>
#
# The following packages are built by the script:
# ATS-Postiats, ATS-Postiats-contrib, and ATS-include
#
######
#
# HX-2018-03-18:
# A typical use of this script
# (for versions 0.3.10+ of ATS only):
# the first argument to the script is the release to be built:
#
# cd /tmp
# sh ${PATSHOME}/share/SCRIPT/build_release.sh 0.3.10
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
#
# HX-2018-12-01:
# Please make sure that
# the version number in configure.ac is properly updated!!!
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

export PATSHOME=${PWD}/ATS-Postiats
export PATSCONTRIB=${PWD}/ATS-Postiats-contrib

######

$GIT clone \
https://github.com/githwxi/ATS-Postiats.git \
|| (cd ATS-Postiats && $GIT pull origin master)

######

$GIT clone \
https://github.com/githwxi/ATS-Postiats-contrib.git \
|| (cd ATS-Postiats-contrib && $GIT pull origin master)

######

PATSVERSION=$1
if [ -z "$PATSVERSION" ] ;
  then PATSVERSION=$(cat "${PATSHOME}/VERSION")
fi

AC_INIT_VERSION="AC_INIT([ATS2/Postiats], [${PATSVERSION}], [gmpostiats@gmail.com])"
if grep -Fxq "$AC_INIT_VERSION" "${PATSHOME}/doc/DISTRIB/ATS-Postiats/configure.ac"
then
    echo "Correct version found in configure.ac"
else
    echo "Failure: Didn't find correct Postiats version for AC_INIT in configure.ac!"
    exit -1;
fi

######

(\
cd "$PATSHOME" && \
$GIT checkout "tags/v${PATSVERSION}" && \
make -f Makefile_devl && \
make -C src -f Makefile CBOOTgmp  && \
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

ls -alh "$PATSHOME/doc/DISTRIB/"ATS2-*.tgz

###### end of [build_release.sh] ######
