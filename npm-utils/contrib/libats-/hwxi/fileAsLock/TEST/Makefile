#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::
cleanall::

######

all:: \
testlock
testlock: testlock.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) testlock

######

testall:: all
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
