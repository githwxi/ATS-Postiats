#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::tailrec

######

tailrec: tailrec.dats ; $(PATSCC) -tcats $@ $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~

cleanall:: clean

######

###### end of [Makefile] ######
