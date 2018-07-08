#
# A simple Makefile
#
######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2JS=${PATSHOME}/bin/atscc2js

######

NODEJS=nodejs

######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.js
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.js: \
QueenPuzzle_dfs_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.js; $(NODEJS) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.js
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.js: \
QueenPuzzle_bfs_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.js; $(NODEJS) $<
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

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.js

######

###### end of [Makefile] ######
