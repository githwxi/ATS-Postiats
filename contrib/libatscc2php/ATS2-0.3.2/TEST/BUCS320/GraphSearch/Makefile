#
# A simple Makefile
#
######

PHP=php

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2PHP=${PATSHOME}/bin/atscc2php

######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.php
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.php: \
QueenPuzzle_dfs_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.php; $(PHP) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.php
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.php: \
QueenPuzzle_bfs_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.php; $(PHP) $<
#
######
#
all:: \
GameOf24Play_dfs_dats.php
GameOf24Play_dfs_dats.c: \
GameOf24Play_dfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_dfs_dats.php: \
GameOf24Play_dfs_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
regress:: GameOf24Play_dfs_dats.php; $(PHP) $<
#
######
#
all:: \
GameOf24Play_bfs_dats.php
GameOf24Play_bfs_dats.c: \
GameOf24Play_bfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_bfs_dats.php: \
GameOf24Play_bfs_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
regress:: GameOf24Play_bfs_dats.php; $(PHP) $<
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
cleanall:: ; $(RMF) *_?ats.php

######

###### end of [Makefile] ######
