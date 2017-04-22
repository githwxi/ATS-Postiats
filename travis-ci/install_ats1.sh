#!/usr/bin/env sh

######
#
# Author: Kiwamu Okabe
# Author: Hongwei Xi (tidying-up)
#
######
#
# for installing ats-anairiats
#
######
#
ATSPACK=ats-lang-anairiats-${ATSVER}
ATSPACKTGZ=${ATSPACK}.tgz
#
ATSLANGURL_srcfg=http://sourceforge.net/projects/ats-lang
ATSLANGURL_github=http://ats-lang.github.io
#
######
#
wget -q ${ATSLANGURL_github}/ATS-Anairiats/${ATSPACKTGZ}
# wget -q ${ATSLANGURL_srcfg}/files/ats-lang/anairiats-latest/${ATSPACKTGZ}
tar -zxf ${ATSPACKTGZ}
rm ${ATSPACKTGZ}
#
######
#
(cd ${ATSHOME} && ./configure && make CC=${CC} all_ngc)
(cd ${ATSHOME}/bootstrap1 && rm -f *.o)
(cd ${ATSHOME}/ccomp/runtime/GCATS && make && make clean)
#
######
#
# HX-2014-12-16:
# The rest is moved into .travis.yml
#
######
#
# ./configure; make all
#
######
#
# -- If you do
#
# ./configure; make all_ngc
#
# -- Please remember to use the following
# -- command-line later when building ATS2
#
# make GCFLAG=-D_ATS_NGC all
#
######

###### end of [install_ats1.sh] ######
