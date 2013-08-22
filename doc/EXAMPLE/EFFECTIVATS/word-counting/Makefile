#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::wordcnt

######

wordcnt: wordcnt.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) wordcnt

######

###### end of [Makefile] ######
