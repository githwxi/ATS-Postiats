#!/bin/bash

TCC=tcc

if [ ! -f QueenPuzzle_anim2_dats.c ] ;
then
  echo "**ERROR**: please try to generate the needed C code: make QueenPuzzle_anim2_dats.c" ; exit 1 ;
fi

${TCC} -run \
  -DATS_MEMALLOC_LIBC \
  -I${PATSHOME} \
  -I${PATSHOME}/ccomp/runtime \
  -I${PATSHOMERELOC}/contrib \
  `pkg-config gtk+-3.0 --cflags --libs` \
  QueenPuzzle_anim2_dats.c >& /dev/null &

### end of [QueenPuzzle_anim2.sh] ######
