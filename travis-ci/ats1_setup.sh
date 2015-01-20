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
ATSVER=$1
#
ATSPACK=\
ats-lang-anairiats-${ATSVER}
#
ATSPACKTGZ=${ATSPACK}.tgz
#
ATSLANGURL=\
http://sourceforge.net/projects/ats-lang
#
######
#
WGETQ="wget -q"
TARZXF="tar -zxf"
#
######
#
${WGETQ} \
${ATSLANGURL}/files/ats-lang/anairiats-${ATSVER}/${ATSPACKTGZ}
#
${TARZXF} ${ATSPACKTGZ}
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

###### end of [ats1_setup.sh] ######
