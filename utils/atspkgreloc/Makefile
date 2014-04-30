#
# Makefile for [atscc]
#

######
#
CC=gcc -std=c99 -D_XOPEN_SOURCE
#
#CC=clang -std=c99 -D_XOPEN_SOURCE
#
######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

CFLAGS :=

######

LDFLAGS :=
LDFLAGS := -L$(PATSLIB) -latslib

######

atspkgreloc: atspkgreloc.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) atspkgreloc

######

###### end of [Makefile] ######
