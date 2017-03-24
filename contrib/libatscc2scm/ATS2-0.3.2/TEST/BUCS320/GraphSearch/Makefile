######
#
# A simple Makefile
#
######
#
PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
#
ATSCC2SCM=${PATSHOME}/bin/atscc2scm
#
######
#
SCHEME=guile
#
SCHEME2=$(SCHEME) \
  -l ./../../../output/libatscc2scm_all.scm
#
######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.scm
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.scm: \
QueenPuzzle_dfs_dats.c; $(ATSCC2SCM) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.scm; $(SCHEME2) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.scm
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.scm: \
QueenPuzzle_bfs_dats.c; $(ATSCC2SCM) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.scm; $(SCHEME2) $<
#
######
#
all:: \
GameOf24Play_dfs_dats.scm
GameOf24Play_dfs_dats.c: \
GameOf24Play_dfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_dfs_dats.scm: \
GameOf24Play_dfs_dats.c; $(ATSCC2SCM) -o $@ -i $<
#
regress:: GameOf24Play_dfs_dats.scm; $(SCHEME2) $<
#
######
#
all:: \
GameOf24Play_bfs_dats.scm
GameOf24Play_bfs_dats.c: \
GameOf24Play_bfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_bfs_dats.scm: \
GameOf24Play_bfs_dats.c; $(ATSCC2SCM) -o $@ -i $<
#
regress:: GameOf24Play_bfs_dats.scm; $(SCHEME2) $<
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
cleanall:: ; $(RMF) *_?ats.scm

######

###### end of [Makefile] ######
