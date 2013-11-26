#
# A simple Makefile
#

######

CC=gcc

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib
PATSLIB64=$(PATSHOMEQ)/ccomp/atslib/lib64

######

PATSCCOMP=$(CC) -D_XOPEN_SOURCE -I${PATSHOMEQ} -I${PATSHOMEQ}/ccomp/runtime

######

export PATSCCOMP

######

all:: linenumbering

######

linenumbering: linenumbering.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -L$(PATSLIB64) -latslib
cleanall:: ; $(RMF) linenumbering

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

######

###### end of [Makefile] ######
