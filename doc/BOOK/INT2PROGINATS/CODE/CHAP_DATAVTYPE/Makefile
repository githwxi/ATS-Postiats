#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CFLAGS=-O2
ATSCFLAGS=

######

all:: list_vt
list_vt: list_vt.dats; $(PATSCC) -tcats -o $@ $<

all:: mergesort
mergesort: mergesort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) mergesort

all:: rbtree
rbtree: rbtree.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) rbtree

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
