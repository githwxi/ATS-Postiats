##
##
## A simple Makefile
##
##

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -O2 -DATS_MEMALLOC_LIBC

######

all:: mergesort
mergesort: ; $(PATSCC) -tcats mergesort.dats

all:: mergesort_list
mergesort_list: ; $(PATSCC2) -o $@ mergesort_list.dats
cleanall:: ; $(RMF) mergesort_list

all:: mergesort_array
mergesort_array: ; $(PATSCC2) -o $@ mergesort_array.dats
cleanall:: ; $(RMF) mergesort_array

######

include $(PATSHOME)/share/atsmake-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
