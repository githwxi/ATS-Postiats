######
#
# A simple Makefile
#
######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::

######

all:: \
test_which
test_which: \
test_which.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

all:: \
test_download
test_download: \
test_download.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

testall:: all
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) test_which
cleanall:: ; $(RMF) test_download

###### end of [Makefile] ######
