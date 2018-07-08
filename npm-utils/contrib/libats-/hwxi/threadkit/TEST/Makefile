#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

all::
regress::
cleanall::

######

all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: test01; ./$<
cleanall:: ; $(RMF) test01

######

all:: \
test02
test02: \
test02.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< -lpthread
regress:: test02; ./$<
cleanall:: ; $(RMF) test02

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

######

cleanall:: clean

###### end of [Makefile] ######
