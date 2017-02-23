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
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

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
all:: \
Fibonacci
Fibonacci: \
Fibonacci.dats; $(PATSCC2) -o $@ $<
#
regress:: Fibonacci; ./$<
cleanall:: ; $(RMF) Fibonacci
#
######
#
all:: \
MCarthy91
MCarthy91: \
MCarthy91.dats; $(PATSCC2) -o $@ $<
#
regress:: MCarthy91; ./$<
cleanall:: ; $(RMF) MCarthy91
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
