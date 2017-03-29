#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

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
$(PATSCC) -O2 -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: QueenPuzzle_bfs; ./$<
#
######
#
all:: \
QueenPuzzle_dfs
QueenPuzzle_dfs: \
QueenPuzzle_dfs.dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: QueenPuzzle_dfs; ./$<
#
######
#
all:: \
KnightsTour_bfs
KnightsTour_bfs: \
KnightsTour_bfs.dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
#
regress:: KnightsTour_bfs; ./$<
#
######
#
all:: \
KnightsTour_dfs
KnightsTour_dfs: \
KnightsTour_dfs.dats; \
$(PATSCC) -O2 -DATS_MEMALLOC_GCBDW -o $@ $< -lgc
#
regress:: KnightsTour_dfs; ./$<
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
cleanall:: ; $(RMF) KnightsTour_bfs
cleanall:: ; $(RMF) KnightsTour_dfs
#
######

###### end of [Makefile] ######
