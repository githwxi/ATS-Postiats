#!/bin/bash

######

WGET=wget
TCCRUN='tcc -run'

######

__CFLAGS__LIBS=`pkg-config gtk+-3.0 --cflags --libs`

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
# wget -q -O - ... | tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib `pkg-config gtk+-3.0 --cflags --libs` - >& /dev/null
#
######
#
# HX-2014-03-31: Here are some examples:
#
# ./wgetccrun_gtk3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/quicksort/GTK/quicksort_anim_dats.c
# ./wgetccrun_gtk3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/insertsort/GTK/insertsort_anim2_all_dats.c
# ./wgetccrun_gtk3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-breadth-all_dats.c
# ./wgetccrun_gtk3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-breadth-all_dats.c
#
######

###### end of [wgetccrun_gtk3.sh] ######
