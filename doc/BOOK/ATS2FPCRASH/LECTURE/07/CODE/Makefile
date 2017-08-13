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
lecture07
lecture07: ; \
$(MYATSCC) lecture07.dats

######

regress:: lecture07; ./lecture07_dats

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
