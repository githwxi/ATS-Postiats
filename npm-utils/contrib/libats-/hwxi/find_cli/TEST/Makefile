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
$(PATSCC) -O2 \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC
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
$(PATSCC2) -o $@ $^ -latslib -lpthread
#
regress:: test01; ./$<
cleanall:: ; $(RMF) test01
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
