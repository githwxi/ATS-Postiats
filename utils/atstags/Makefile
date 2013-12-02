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

CFLAGS :=
CFLAGS += -I $(PATSHOMEQ)/contrib
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs json-c)

######


######

jsonlst2arr: jsonlst2arr.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)

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
