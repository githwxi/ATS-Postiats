#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all:: array-queue

######

array-queue: array-queue.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) array-queue

######

###### end of [Makefile] ######