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

######

all:: patscc

######

patscc: \
  patscc_dats.c \
  atscc_main_dats.c \
  atscc_print_dats.c ; \
  $(CC) -I${PATSHOMEQ} -I${PATSHOMEQ}/ccomp/runtime -DATS_MEMALLOC_LIBC -O2 -o $@ $^

######

%_dats.c: %.dats; $(PATSOPT) --output $@ --dynamic $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) patscc

######

###### end of [Makefile] ######
