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

all:: \
bug-2013-10-07
bug-2013-10-07: \
  bug-2013-10-07.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-07

######

all:: \
bug-2013-10-09
bug-2013-10-09: \
  bug-2013-10-09.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-09

######

all:: \
bug-2013-10-11
bug-2013-10-11: bug-2013-10-11.dats ; $(PATSCC) -ccats $<
cleanall:: ; $(RMF) bug-2013-10-11_dats.c

######

all:: \
bug-2013-10-11-2
bug-2013-10-11-2: bug-2013-10-11-2.dats ; $(PATSCC) -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-11-2

######

all:: \
bug-2013-10-30
bug-2013-10-30: bug-2013-10-30.dats ; $(PATSCC) -ccats $<
cleanall:: ; $(RMF) bug-2013-10-30_dats.c

######

all:: \
bug-2013-10-30-2
bug-2013-10-30-2: bug-2013-10-30-2.dats ; $(PATSCC) -o $@ $<
cleanall:: ; $(RMF) bug-2013-10-30-2

######

all:: \
bug-2013-11-01
bug-2013-11-01: bug-2013-11-01.dats ; $(PATSCC) -o $@ $<
cleanall:: ; $(RMF) bug-2013-11-01

######

all:: \
bug-2013-11-06
bug-2013-11-06: bug-2013-11-06.dats ; $(PATSCC) -o $@ $<
cleanall:: ; $(RMF) bug-2013-11-06

######
#
# all:: \
# bug-2013-11-10
# bug-2013-11-10: bug-2013-11-10.dats ; $(PATSCC) -o $@ $<
# cleanall:: ; $(RMF) bug-2013-11-10
#
######

all:: \
bug-2013-11-29
bug-2013-11-29: bug-2013-11-29.dats ; $(PATSCC) -tcats $<
cleanall:: ; $(RMF) bug-2013-11-29

######

all:: \
bug-2013-12-04
bug-2013-12-04: \
  bug-2013-12-04.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) bug-2013-12-04

######
#
# all:: \
# bug-2014-02-15
# bug-2014-02-15: \
#   bug-2014-02-15.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
# cleanall:: ; $(RMF) bug-2014-02-15
#
######

all:: \
bug-2014-05-17
bug-2014-05-17: ; $(PATSCC) -tcats bug-2014-02-15.dats

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
