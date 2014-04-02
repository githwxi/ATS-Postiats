#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

__CFLAGS__LIBS=

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
  -I${PATSHOMERELOC}/contrib \
   $__CFLAGS__LIBS -
#
###### end of [wgetccrun.sh] ######
