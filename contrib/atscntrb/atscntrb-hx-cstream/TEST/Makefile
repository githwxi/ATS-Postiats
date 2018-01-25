######
#
# A simple Makefile
#
######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

MALLOCFLAG = -DATS_MEMALLOC_LIBC

######

all:: test01
test01: test01.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $<
regress:: test01; ./$<
cleanall:: ; $(RMF) test01

######

all:: test02
test02: test02.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $<
regress:: test02; ./$<
cleanall:: ; $(RMF) test02

######

all:: test03
test03: test03.dats ; $(PATSCC2) $(MALLOCFLAG) -o $@ $<
regress:: test03; ./$<
cleanall:: ; $(RMF) test03

######

all:: tokener
tokener: tokener.dats ; $(PATSCC2) -O2 $(MALLOCFLAG) -o $@ $<
regress:: tokener; ./$<
cleanall:: ; $(RMF) tokener

######

include \
$(PATSHOME)/share/atsmake-post.mk

######

testall:: all
testall:: regress
testall:: cleanall

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
