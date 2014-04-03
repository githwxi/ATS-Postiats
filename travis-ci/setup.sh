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
ATSPACK=ats-lang-anairiats-${ATSVER}
ATSPACKTGZ=${ATSPACK}.tgz
#
ATSLANGURL=\
http://downloads.sourceforge.net/project/ats-lang
#
######

WGETQ="wget -q"
TARZXF="tar zxf"

######
#
${WGETQ} \
${ATSLANGURL}/ats-lang/anairiats-${ATSVER}/${ATSPACKTGZ}
#
${TARZXF} ${ATSPACKTGZ}
#
######
#
cd ${ATSPACK}; ./configure; make all
#
######

###### end of [setup.sh] ######
