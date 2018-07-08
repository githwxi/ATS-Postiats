#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######
#
all:: \
test01
test01: \
test01.dats; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -O2 -o $@ $< -latslib
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
test02
test02: \
test02.dats; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -O2 -o $@ $< -latslib
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
#
######
#
all:: \
test03
test03: \
test03.dats; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -O2 -o $@ $< -latslib
#
regress:: test03; ./$<
cleanall:: ; $(RMF) test03
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

######

cleanall:: clean

###### end of [Makefile] ######
