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

include $(PATSHOME)/share/atsmake-post.mk

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

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

clean:: cleanats

######

###### end of [Makefile] ######
