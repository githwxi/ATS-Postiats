#
# A simple Makefile
#
######

PERL=perl

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2PL=${PATSHOME}/bin/atscc2pl

######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.pl
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.pl: \
QueenPuzzle_dfs_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.pl; $(PERL) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.pl
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.pl: \
QueenPuzzle_bfs_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.pl; $(PERL) $<
#
######
#
all:: \
GameOf24Play_dfs_dats.pl
GameOf24Play_dfs_dats.c: \
GameOf24Play_dfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_dfs_dats.pl: \
GameOf24Play_dfs_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: GameOf24Play_dfs_dats.pl; $(PERL) $<
#
######
#
all:: \
GameOf24Play_bfs_dats.pl
GameOf24Play_bfs_dats.c: \
GameOf24Play_bfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_bfs_dats.pl: \
GameOf24Play_bfs_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: GameOf24Play_bfs_dats.pl; $(PERL) $<
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
cleanall:: ; $(RMF) *_?ats.pl

######

###### end of [Makefile] ######
