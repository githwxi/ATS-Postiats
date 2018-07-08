######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
MYATSCC=$(PATSHOME)/bin/myatscc

######

all::

######

all:: \
MonteCarlo_dats
MonteCarlo_dats: \
MonteCarlo.dats; \
$(PATSCC) -DATS_MEMALLOC_LIBC -O2 -o $@ $< -lm

######

regress:: MonteCarlo_dats; ./$<

######

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_dats
cleanall:: ; rm -f *_dats.c

######

testall:: all
testall:: regress
testall:: cleanall

###### end of [Makefile] ######
