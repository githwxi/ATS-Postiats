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
   $__CFLAGS__LIBS - >& /dev/null &
#
######
#
# HX-2014-03-31: Here are some examples:
#
# ./wgetccrun3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-depth-all_dats.c
# wget -q -O - http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-depth-all_dats.c | tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib `pkg-config gtk+-3.0 --cflags --libs` - >& /dev/null &
#
# ./wgetccrun3.sh http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-breadth-all_dats.c
# wget -q -O - http://www.ats-lang.org/COMPILED/doc/PROJECT/MEDIUM/Algorianim/QueenPuzzle/GTK/QueenPuzzle-breadth-all_dats.c | tcc -run -DATS_MEMALLOC_LIBC -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -I${PATSHOMERELOC}/contrib `pkg-config gtk+-3.0 --cflags --libs` - >& /dev/null &
#
######

###### end of [wgetccrun_gtk3.sh] ######
