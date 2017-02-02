#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=$(PATSCC) \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC -O2

######

all::
regress::
cleanall::

######
#
all:: \
test01
test01: \
test01.dats \
testlib_dats.o; \
$(PATSCC2) -o $@ $< testlib_dats.o
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######
#
all:: \
testlib_dats.o
testlib_dats.o: \
testlib.dats; \
$(PATSCC2) -c $< \
MergeSort_list_int.dats \
MergeSort_list_double.dats
#
cleanall:: ; $(RMF) testlib_dats.o
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
#
cleanall:: clean
#
######

###### end of [Makefile] ######
