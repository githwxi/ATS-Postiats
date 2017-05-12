#
# Makefile for [atscc]
#

######
#
CC=gcc
CFLAGS=-std=c99 -D_XOPEN_SOURCE
#
######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

INCLUDE=-I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime

######

all:: clean
all:: patscc

######
#
patscc: \
  patscc_dats.c \
  atscc_main_dats.c \
  atscc_print_dats.c ; \
  $(CC) $(INCLUDE) $(CFLAGS) -DATS_MEMALLOC_LIBC -O2 -o $@ $^
#
######

%_dats.c: %.dats; $(PATSOPT) --output $@ --dynamic $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) patscc

######

###### end of [Makefile] ######
