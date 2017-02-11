#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######
#
PATSCC2=\
$(PATSCC) \
-O2 -D_GNU_SOURCE \
-DATS_MEMALLOC_LIBC \
-D_ATS_CCOMP_ASSUME_CHECK_NONE_
#
######
#
export \
PATSHOMELOCS=\
./node_modules:./../../node_modules
#
######

all::
regress::
cleanall::

######
#
OBJECTS :=
OBJECTS += MergeSort_list_int_dats.o
OBJECTS += MergeSort_list_double_dats.o
#
######
#
all:: \
test01
test01: \
test01.dats $(OBJECTS); $(PATSCC2) -o $@ $^
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######

all:: \
MergeSort_list_int_dats.o
MergeSort_list_int_dats.o: MergeSort_list_int.dats; $(PATSCC2) -c $<
all:: \
MergeSort_list_double_dats.o
MergeSort_list_double_dats.o: MergeSort_list_double.dats; $(PATSCC2) -c $<

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
