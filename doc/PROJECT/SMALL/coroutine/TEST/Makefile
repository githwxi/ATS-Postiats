#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

test1: test1.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) test1

######

###### end of [Makefile] ######