#!/bin/sh

#
# Written by Brandon Barker <brandon dot barker at cornell dot edu>
#

ATSCC=$(which atscc)
if [ -x "$ATSCC" ] ; 
  then echo "$ATSCC found.";
  else echo "$ATSCC not found." exit 1;
fi

GIT=$(which git)
if [ -x "$GIT" ] ; 
  then echo "$GIT found.";
  else echo "$GIT not found." exit 1;
fi

if [ -z ${PATSHOME+x} ]; 
  then echo "PATSHOME is unset"; exit 1;
  else echo "PATSHOME is set to '$PATSHOME'";
fi

if [ -z ${PATSCONTRIB+x} ]; 
  then echo "PATSCONTRIB is unset"; exit 1;
  else echo "PATSCONTRIB is set to '$PATSCONTRIB'";
fi

cd $PATSCONTRIB && \
git checkout master && \
git fetch upstream && \
git merge upstream/master && \
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
make -C doc/DISTRIB -f Makefile_inclats tarzvcf && \
ls -al doc/DISTRIB/ATS2-*.tgz

