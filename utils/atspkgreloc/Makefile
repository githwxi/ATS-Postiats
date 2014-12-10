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
#
CFLAGS :=
#
CFLAGS += $(shell pkg-config --cflags json-c)
CFLAGS += $(shell pkg-config --cflags libcurl)
#
######
#
LDFLAGS :=
#
LDFLAGS += $(shell pkg-config --libs json-c)
LDFLAGS += $(shell pkg-config --libs libcurl)
#
######

all:: atspkgreloc_curl
all:: atspkgreloc_wget

######

atspkgreloc_curl: \
atspkgreloc_curl.dats ; \
  $(PATSCC) -I . -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)

######

atspkgreloc_wget: \
atspkgreloc_wget.dats \
atspkgreloc_wget_lib.dats ; \
  $(PATSCC) -I . -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $^ $(LDFLAGS)

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) atspkgreloc_curl
cleanall:: ; $(RMF) atspkgreloc_wget

######

###### end of [Makefile] ######
