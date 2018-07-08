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

MYTEXTING=./../MYTEXT/bin/mytexting

######

all::
regress::
cleanall::

######
#
all:: \
test_single
test_single: \
test_single.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: test_single; ./$<
#
######
#
all:: \
hangman_single
hangman_single: \
hangman_single.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -L$(PATSLIB) -latslib
#
# regress:: hangman_single; ./$<
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
cleanall:: ; $(RMF) test_single
cleanall:: ; $(RMF) hangman_single
#
######

###### end of [Makefile] ######
