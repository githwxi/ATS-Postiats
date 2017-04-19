#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

MY_CFLAGS_LIBS="-L/usr/lib -lgc"

######
#
# echo $1
#
######
#
${WGET} -q -O - $1 | \
${TCCRUN} \
-DATS_MEMALLOC_GCBDW \
-I${PATSHOME} \
-I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib \
 $MY_CFLAGS_LIBS -
#
###### end of [wgetccrun_gcbdw.sh] ######
