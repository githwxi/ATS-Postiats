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
QueenPuzzle: \
QueenPuzzle.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: QueenPuzzle; ./$<
#
######
#
DoubletsPlay: \
DoubletsPlay.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC \
  -o $@ $< -L $(PATSLIB) -latslib
#
regress:: DoubletsPlay; ./$< clean dirty
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) QueenPuzzle
cleanall:: ; $(RMF) DoubletsPlay
#
######

###### end of [Makefile] ######
