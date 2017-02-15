#
# A simple Makefile
#
######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2PY=${PATSHOME}/bin/atscc2py3

######

PYTHON=python3
export PYTHONPATH=./../../../output

######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.py
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.py: \
QueenPuzzle_dfs_dats.c; $(ATSCC2PY) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.py; $(PYTHON) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.py
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.py: \
QueenPuzzle_bfs_dats.c; $(ATSCC2PY) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.py; $(PYTHON) $<
#
######
#
all:: \
GameOf24Play_dfs_dats.py
GameOf24Play_dfs_dats.c: \
GameOf24Play_dfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_dfs_dats.py: \
GameOf24Play_dfs_dats.c; $(ATSCC2PY) -o $@ -i $<
#
regress:: GameOf24Play_dfs_dats.py; $(PYTHON) $<
#
######
#
all:: \
GameOf24Play_bfs_dats.py
GameOf24Play_bfs_dats.c: \
GameOf24Play_bfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_bfs_dats.py: \
GameOf24Play_bfs_dats.c; $(ATSCC2PY) -o $@ -i $<
#
regress:: GameOf24Play_bfs_dats.py; $(PYTHON) $<
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
cleanall:: ; $(RMF) *_?ats.py

######

###### end of [Makefile] ######
