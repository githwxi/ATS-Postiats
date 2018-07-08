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
lecture10
lecture10: ; \
$(MYATSCC) lecture10.dats

######

regress:: lecture10; ./lecture10_dats

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
