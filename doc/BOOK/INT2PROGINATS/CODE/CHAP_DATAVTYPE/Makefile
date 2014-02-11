#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

CFLAGS=-O2
ATSCFLAGS=

######

all:: list_vt
list_vt: list_vt.dats; $(PATSCC) -tcats -o $@ $<

######

all:: rbtree
rbtree: rbtree.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) rbtree

######

all:: mergeSort
mergeSort: mergeSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) mergeSort

######

all:: insertionSort
insertionSort: insertionSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) insertionSort

######

all:: quickSort
quickSort: quickSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) quickSort

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
