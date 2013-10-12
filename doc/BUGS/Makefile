#
# A simple Makefile
# for testing doc/EXAMPLE/INTRO
#

######

CC=gcc

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCCOMP=$(CC) -D_XOPEN_SOURCE -I${PATSHOMEQ} -I${PATSHOMEQ}/ccomp/runtime

######

export PATSCCOMP

######

all::

######

all:: bug-2013-10-07
bug-2013-10-07: \
  bug-2013-10-07.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-07

######

all:: bug-2013-10-09
bug-2013-10-09: \
  bug-2013-10-09.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-09

######

all:: bug-2013-10-11
bug-2013-10-11: \
  bug-2013-10-11.dats ; $(PATSCC) -ccats -DATS_MEMALLOC_LIBC $<
cleanall:: ; $(RMF) bug-2013-10-11_dats.c

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######
