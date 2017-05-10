#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

MY_CFLAGS_LIBS=

######
#
# echo $1
#
######
#
${WGET} -q -O - $1 | \
${TCCRUN} \
-DATS_MEMALLOC_LIBC \
-I${PATSHOME} \
-I${PATSHOME}/ccomp/runtime \
-I${PATSHOME}/contrib \
-I${PATSHOME}/npm-utils/contrib \
-I${PATSCONTRIB}/contrib \
 $MY_CFLAGS_LIBS -
#
###### end of [wgetccrun.sh] ######
