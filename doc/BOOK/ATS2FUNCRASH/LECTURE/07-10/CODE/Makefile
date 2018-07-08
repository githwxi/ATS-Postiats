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
Game-of-24
Game-of-24: ; \
$(MYATSCC) Game-of-24.dats

######

all:: \
Game-of-24-js
Game-of-24-js: ; \
$(MYATSCC) Game-of-24-js.dats

######

regress:: Game-of-24_dats; ./$<

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats
cleanall:: ; rm -f *_dats.c
cleanall:: ; rm -f *_dats.js

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
