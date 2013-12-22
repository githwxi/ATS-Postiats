##
##
## A simple Makefile
##
##

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

ATSCCFLAGS=-O2 -DATS_MEMALLOC_GCBDW -IIATS $(PATSHOMERELOCQ)/contrib

######

all:: mergesort
all:: mergesort_list
all:: mergesort_array

######

mergesort: ; $(PATSCC) -tcats mergesort.dats
mergesort_list: ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ mergesort_list.dats
mergesort_array: ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ mergesort_array.dats

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/mergesort/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) mergesort_list
cleanall:: ; $(RMF) mergesort_array

###### end of [Makefile] ######
