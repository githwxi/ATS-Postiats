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

PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCCOMP=$(CC) -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

######

export PATSCCOMP

######

all::
regress::
cleanall::

######
#
all:: \
test01
test01: \
test01.dats ; $(PATSCC) -o $@ $<
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats ; $(PATSCC) -o $@ $<
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03: \
test03.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: test03; ./$<
cleanall:: ; $(RMF) test03
#
######
#
all:: \
test04
test04: \
test04.dats ; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: test04; ./$<
cleanall:: ; $(RMF) test04
#
######
#
all:: \
test05-1
test05-1: \
test05-1.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
#
regress:: test05-1; ./$<
cleanall:: ; $(RMF) test05-1
#
######
#
all:: \
test05-2
test05-2: \
test05-2.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
#
regress:: test05-2; ./$<
cleanall:: ; $(RMF) test05-2
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######
