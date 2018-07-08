#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=\
$(PATSCC) -O2 \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######
#
export \
PATSHOMELOCS=\
./node_modules:./../../node_modules
#
######

all::
regress::
cleanall::

######
#
all:: \
QueenPuzzle_bfs
QueenPuzzle_bfs: \
QueenPuzzle_bfs.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: QueenPuzzle_bfs; ./$<
#
######
#
all:: \
QueenPuzzle_dfs
QueenPuzzle_dfs: \
QueenPuzzle_dfs.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: QueenPuzzle_dfs; ./$<
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) QueenPuzzle_bfs
cleanall:: ; $(RMF) QueenPuzzle_dfs
#
######

###### end of [Makefile] ######
