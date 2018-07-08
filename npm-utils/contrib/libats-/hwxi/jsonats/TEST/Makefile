#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

include \
$(PATSHOME)/share/atsmake-post.mk

######
#
PATSCC2=$(PATSCC) $(INCLUDE)
INCLUDE+=-IIATS $(PATSCONTRIB)/contrib
#
######

all::
regress::
cleanall::

######

all:: test01
test01: test01.dats ; \
$(PATSCC2) -O2 $(MALLOCFLAG) -o $@ $<
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; \
$(PATSCC2) -O2 $(MALLOCFLAG) -o $@ $<
cleanall:: ; $(RMF) test02

######

regress:: test01 ; ./test01
regress:: test02 ; ./test02 < DATA/atsreloc.json

######

testall:: all
testall:: regress
testall:: cleanall

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
