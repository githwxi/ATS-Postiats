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
regress::
cleanall::

######

all:: \
test_spinref
test_spinref: \
test_spinref.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: test_spinref; ./$<
cleanall:: ; $(RMF) test_spinref

######

all:: \
test_nwaiter
test_nwaiter: \
test_nwaiter.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: test_nwaiter; ./$<
cleanall:: ; $(RMF) test_nwaiter

######

all:: \
test_workshop
test_workshop: \
test_workshop.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: test_workshop; ./$<
cleanall:: ; $(RMF) test_workshop

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

###### end of [Makefile] ######
