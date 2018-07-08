#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=\
$(PATSCC) -O2 \
-D_GNU_SOURCE -DATS_MEMALLOC_GCBDW

######
#
export \
PATSHOMELOCS=\
./node_modules:./../node_modules:./../../node_modules
#
######

all::
regress::
cleanall::

######
#
all:: \
test01
test01: \
test01.dats; \
$(PATSCC2) -o $@ $< -lgc -lpthread
#
######
#
all:: \
test02
test02: \
test02.dats; \
$(PATSCC2) -o $@ $< -lgc -lpthread
#
######
#
all:: \
test03
test03: \
test03.dats; \
$(PATSCC2) -o $@ $< -lgc -lpthread
#
######
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
regress:: test02; ./$<
cleanall:: ; $(RMF) test02
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

######
#
cleanall:: clean
#
######

###### end of [Makefile] ######
