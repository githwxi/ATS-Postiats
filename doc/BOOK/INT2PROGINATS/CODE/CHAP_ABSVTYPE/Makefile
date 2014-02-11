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
ATSCFLAGS=
LDFLAGS=-latslib

######

all:: mergeSort
mergeSort: mergeSort.dats
	$(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) $(ATSCFLAGS) -o $@ $< $(LDFLAGS) && ./$@
cleanall:: ; $(RMF) mergeSort

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
