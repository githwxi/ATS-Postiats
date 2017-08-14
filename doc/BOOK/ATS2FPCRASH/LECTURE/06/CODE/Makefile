######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc

######

all::

######

all:: \
lecture06
lecture06: ; \
$(MYATSCC) lecture06.dats

######

all:: \
QueenPuzzle
QueenPuzzle: ; \
$(MYATSCC) QueenPuzzle.dats

######

regress:: lecture06; ./lecture06_dats
regress:: QueenPuzzle; ./QueenPuzzle_dats

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
