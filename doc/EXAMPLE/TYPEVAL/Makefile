#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc

######

all::

######

all:: \
dotprod
dotprod: dotprod.dats; $(PATSCC) -O2 -o $@ $<
regress:: dotprod; ./$< || (echo "$< failed" && exit 1)
cleanall:: ; $(RMF) dotprod

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

cleanall:: clean

###### end of [Makefile] ######
