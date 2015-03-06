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

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *_?ats.o

######

cleanall:: clean
cleanall:: ; rm -f dotprod

###### end of [Makefile] ######