#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::wordcnt
all::wordcnt2
all::wordcnt_vt

######

wordcnt: wordcnt.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $< -L$(PATSHOME)/ccomp/atslib -latslib

######

wordcnt2: wordcnt2.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $< -L$(PATSHOME)/ccomp/atslib -latslib

######

wordcnt_vt: wordcnt_vt.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $< -L$(PATSHOME)/ccomp/atslib -latslib

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
cleanall:: ; $(RMF) wordcnt_vt

######

###### end of [Makefile] ######
