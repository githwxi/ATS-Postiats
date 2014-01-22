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

all:: test01
test01: test01.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< testlib.dats
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< testlib.dats
cleanall:: ; $(RMF) test02

######

all:: test03
test03: test03.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $< testlib.dats
cleanall:: ; $(RMF) test03

######

all:: tokener
tokener: tokener.dats ; $(PATSCC2) -O2 $(MALLOCFLAG) -o $@ $< testlib.dats
cleanall:: ; $(RMF) tokener

######

include \
$(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######