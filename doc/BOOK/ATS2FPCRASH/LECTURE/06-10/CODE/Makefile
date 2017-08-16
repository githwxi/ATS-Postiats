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
Factorial
Factorial: ; \
$(MYATSCC) Factorial.dats

######

all:: \
QueenPuzzle
QueenPuzzle: ; \
$(MYATSCC) QueenPuzzle.dats

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats.c
cleanall:: ; rm -f *_dats.js

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
