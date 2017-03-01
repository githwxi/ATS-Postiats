#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######

all:: \
sieve
sieve: \
sieve.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: sieve; ./$<
cleanall:: ; $(RMF) sieve

######

all:: \
bitstr
bitstr: \
bitstr.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: \
bitstr; ./bitstr 123 987
cleanall:: ; $(RMF) bitstr

######

all:: \
mergesort
mergesort: \
mergesort.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: mergesort; ./$<
cleanall:: ; $(RMF) mergesort

######

all:: \
mergesort2
mergesort2: \
mergesort2.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: mergesort2; ./$<
cleanall:: ; $(RMF) mergesort2

######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

######

###### end of [Makefile] ######
