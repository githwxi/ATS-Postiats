#
# Makefile for [atstagging]
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
CFLAGS +=-I$(PATSHOME)/contrib
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs json-c)

######

# cleanall:: ; $(RMF) ats2ctags
# cleanall:: ; $(RMF) ats2etags

######
##
jsonlst2arr: \
jsonlst2arr.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) jsonlst2arr
##
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile for atstagging] ######
