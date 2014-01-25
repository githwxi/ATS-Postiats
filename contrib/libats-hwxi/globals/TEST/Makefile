#
# A simple Makefile
# for testing libats-hwxi/globals
#

######

CC=gcc

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCCOMP=$(CC) -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

######

export PATSCCOMP

######

all::

######

all:: test01
all:: test02
all:: test03

######

test01: \
  test01.dats \
  intvar.dats floatvar.dats ; $(PATSCC) -o $@ $^
cleanall:: ; $(RMF) test01

######

test02: \
  test02.dats gcount1.dats gcount2.dats ; $(PATSCC) -o $@ $^
cleanall:: ; $(RMF) test02

######

test03: test03.dats \
  gstacklst.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $^
cleanall:: ; $(RMF) test03

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
