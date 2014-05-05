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
list_vt: list_vt.dats; $(PATSCC) -o $@ $<
regress:: list_vt; ./list_vt

######

all:: rbtree
rbtree: rbtree.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
regress:: rbtree; ./rbtree

######

all:: mergeSort
mergeSort: mergeSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
regress:: mergeSort; ./mergeSort

######

all:: insertionSort
insertionSort: insertionSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
regress:: insertionSort; ./insertionSort

######

all:: quickSort
quickSort: quickSort.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -o $@ $< && ./$@
regress:: quickSort; ./quickSort

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) list_vt
cleanall:: ; $(RMF) rbtree
cleanall:: ; $(RMF) mergeSort
cleanall:: ; $(RMF) insertionSort
cleanall:: ; $(RMF) quickSort

###### end of [Makefile] ######
