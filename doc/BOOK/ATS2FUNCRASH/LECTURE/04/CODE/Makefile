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
multable
multable: ; \
$(MYATSCC) multable.dats

######

all:: \
lecture04
lecture04: ; \
$(MYATSCC) lecture04.dats

######

regress:: multable; ./multable_dats
regress:: lecture04; ./lecture04_dats

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
