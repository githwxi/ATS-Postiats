#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

MY_CFLAGS_LIBS=`pkg-config gtk+-2.0 --cflags --libs`

######
#
${WGET} -q -O - $1 | \
${TCCRUN} \
-DATS_MEMALLOC_LIBC \
-I${PATSHOME} \
-I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib \
 $MY_CFLAGS_LIBS - >& /dev/null
#
###### end of [wgetccrun_gtk2.sh] ######
