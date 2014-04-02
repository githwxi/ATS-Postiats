#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

__CFLAGS__LIBS=`pkg-config gtk+-2.0 --cflags --libs`

######
#
${WGET} -q -O - $1 | \
${TCCRUN} \
  -DATS_MEMALLOC_LIBC \
  -I${PATSHOME} \
  -I${PATSHOME}/ccomp/runtime \
  -I${PATSHOMERELOC}/contrib \
   $__CFLAGS__LIBS - >& /dev/null
#
###### end of [wgetccrun_gtk2.sh] ######
