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
-DATS_MEMALLOC_GCBDW \
-D_ATS_CCOMP_ASSUME_CHECK_NONE_
#
######

all::
regress::
cleanall::

######
#
OBJECTS :=
OBJECTS += MergeSortPar_list_int_dats.o
OBJECTS += MergeSortPar_list_double_dats.o
#
######
#
all:: \
test01
test01: \
test01.dats $(OBJECTS); $(PATSCC2) -o $@ $^ -lgc -lpthread
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
#
######

all:: \
MergeSortPar_list_int_dats.o
MergeSortPar_list_int_dats.o: MergeSortPar_list_int.dats; $(PATSCC2) -c $<
all:: \
MergeSortPar_list_double_dats.o
MergeSortPar_list_double_dats.o: MergeSortPar_list_double.dats; $(PATSCC2) -c $<

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
