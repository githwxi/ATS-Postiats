#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::wordcnt

######

wordcnt: wordcnt.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $<
wordcnt2: wordcnt2.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) wordcnt
cleanall:: ; $(RMF) wordcnt2

######

###### end of [Makefile] ######
