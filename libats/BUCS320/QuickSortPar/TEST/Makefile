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
OBJECTS += QuickSortPar_array_int_dats.o
OBJECTS += QuickSortPar_array_double_dats.o
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
#
all:: \
QuickSortPar_array_int_dats.o
QuickSortPar_array_int_dats.o: QuickSortPar_array_int.dats; $(PATSCC2) -c $<
all:: \
QuickSortPar_array_double_dats.o
QuickSortPar_array_double_dats.o: QuickSortPar_array_double.dats; $(PATSCC2) -c $<
#
cleanall:: ; $(RMF) QuickSortPar_array_int_dats.o
cleanall:: ; $(RMF) QuickSortPar_array_double_dats.o
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
#
export \
PATSHOMELOCS=\
./node_modules:./../node_modules:./../../node_modules
#
######

###### end of [Makefile] ######
