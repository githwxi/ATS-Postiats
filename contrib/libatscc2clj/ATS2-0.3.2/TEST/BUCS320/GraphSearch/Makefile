######
#
# A simple Makefile
#
######
#
PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
#
ATSCC2CLJ=${PATSHOME}/bin/atscc2clj
#
######
#
JAVA=java
#
CLOJURE=\
$(JAVA) -Xss4m \
  -cp /usr/share/java/clojure-1.4.jar
#
CLOJURE2=\
$(CLOJURE) clojure.main \
  -i ./../../../output/libatscc2clj_all.clj
#
######

all::

######
#
all:: \
QueenPuzzle_dfs_dats.clj
QueenPuzzle_dfs_dats.c: \
QueenPuzzle_dfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_dfs_dats.clj: \
QueenPuzzle_dfs_dats.c; $(ATSCC2CLJ) -o $@ -i $<
#
regress:: QueenPuzzle_dfs_dats.clj; $(CLOJURE2) $<
#
######
#
all:: \
QueenPuzzle_bfs_dats.clj
QueenPuzzle_bfs_dats.c: \
QueenPuzzle_bfs.dats; $(PATSOPT) -o $@ -d $<
QueenPuzzle_bfs_dats.clj: \
QueenPuzzle_bfs_dats.c; $(ATSCC2CLJ) -o $@ -i $<
#
regress:: QueenPuzzle_bfs_dats.clj; $(CLOJURE2) $<
#
######
#
all:: \
GameOf24Play_dfs_dats.clj
GameOf24Play_dfs_dats.c: \
GameOf24Play_dfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_dfs_dats.clj: \
GameOf24Play_dfs_dats.c; $(ATSCC2CLJ) -o $@ -i $<
#
regress:: GameOf24Play_dfs_dats.clj; $(CLOJURE2) $<
#
######
#
all:: \
GameOf24Play_bfs_dats.clj
GameOf24Play_bfs_dats.c: \
GameOf24Play_bfs.dats; $(PATSOPT) -o $@ -d $<
GameOf24Play_bfs_dats.clj: \
GameOf24Play_bfs_dats.c; $(ATSCC2CLJ) -o $@ -i $<
#
regress:: GameOf24Play_bfs_dats.clj; $(CLOJURE2) $<
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
cleanall:: ; $(RMF) *_?ats.clj

######

###### end of [Makefile] ######
