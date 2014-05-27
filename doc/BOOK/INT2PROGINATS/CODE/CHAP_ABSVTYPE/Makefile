##
##
## A simple Makefile for compiling ATS programs
##
##

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

CFLAGS=-O2
LDFLAGS += -latslib

######

all:: mergeSort
mergeSort: mergeSort.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: mergeSort ; ./mergeSort

######

all:: timer
timer: timer.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -lrt $(LDFLAGS)
regress:: timer ; ./timer

######

all:: circbuf
circbuf: circbuf.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: circbuf ; ./circbuf

######

all:: circbuf2
circbuf2: circbuf2.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: circbuf2 ; ./circbuf2

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) mergeSort
cleanall:: ; $(RMF) timer
cleanall:: ; $(RMF) circbuf
cleanall:: ; $(RMF) circbuf2

###### end of [Makefile] ######
