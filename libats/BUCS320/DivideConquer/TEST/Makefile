#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2

######

all::
regress::
cleanall::

######
#
all:: \
test01
test01: \
test01.dats; $(PATSCC2) -o $@ $<
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats; $(PATSCC2) -o $@ $<
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######

all:: \
mergesort
mergesort: \
mergesort.dats; $(PATSCC2) -o $@ $<
#
regress:: mergesort; ./$<
cleanall:: ; $(RMF) mergesort
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
#
cleanall:: clean
#
######

###### end of [Makefile] ######
