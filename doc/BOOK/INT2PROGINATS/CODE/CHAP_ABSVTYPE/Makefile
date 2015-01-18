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

all:: \
mergeSort
mergeSort: mergeSort.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: mergeSort ; ./mergeSort
cleanall:: ; $(RMF) mergeSort

######

all:: timer
timer: timer.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -lrt $(LDFLAGS)
regress:: timer ; ./timer
cleanall:: ; $(RMF) timer

######

all:: \
circbuf
circbuf: circbuf.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: circbuf ; ./circbuf
cleanall:: ; $(RMF) circbuf

######

all:: \
circbuf2
circbuf2: circbuf2.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: circbuf2 ; ./circbuf2
cleanall:: ; $(RMF) circbuf2

######

all:: \
shared_vt
shared_vt: shared_vt.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -lpthread $(LDFLAGS)
regress:: shared_vt ; ./shared_vt
cleanall:: ; $(RMF) shared_vt

######

all:: \
channel_vt
channel_vt: channel_vt.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< -lpthread $(LDFLAGS)
regress:: channel_vt ; ./channel_vt
cleanall:: ; $(RMF) channel_vt

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
