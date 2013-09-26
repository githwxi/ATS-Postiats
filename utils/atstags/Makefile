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

jsonlst2arr: jsonlst2arr.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -O2 -o $@ $< -ljson-c

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) ats2ctags
cleanall:: ; $(RMF) ats2etags
cleanall:: ; $(RMF) jsonlst2arr

######

###### end of [Makefile] ######
