#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::
all:: dotprod_mt
all:: dotprod2_mt

######

regress::

######

dotprod_mt: \
dotprod_mt.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2 -o $@ $< -lpthread
regress:: dotprod_mt ; ./$<
cleanall:: ; $(RMF) dotprod_mt

######

dotprod2_mt: \
dotprod2_mt.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2 -o $@ $< -lpthread
regress:: dotprod2_mt ; ./$<
cleanall:: ; $(RMF) dotprod2_mt

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

###### end of [Makefile] ######
