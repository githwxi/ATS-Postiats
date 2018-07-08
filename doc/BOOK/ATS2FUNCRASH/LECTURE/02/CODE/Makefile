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
lecture02
lecture02: ; \
$(MYATSCC) lecture02.dats

######

regress:: multable; ./multable_dats
regress:: lecture02; ./lecture02_dats

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats
cleanall:: ; rm -f multable.html

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
