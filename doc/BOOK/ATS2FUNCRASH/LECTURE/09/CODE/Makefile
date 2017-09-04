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
lecture09
lecture09: ; \
$(MYATSCC) lecture09.dats

######

regress:: lecture09; ./lecture09_dats

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
