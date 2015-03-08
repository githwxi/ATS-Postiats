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

######

all:: \
loopcons
loopcons: loopcons.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $<
regress:: loopcons ; ./loopcons
cleanall:: ; $(RMF) loopcons

######

all:: \
list_map
list_map: list_map.dats ; \
  $(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $<
regress:: list_map ; ./list_map
cleanall:: ; $(RMF) list_map

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
