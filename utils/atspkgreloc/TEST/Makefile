#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

test01: test01.dats ; $(PATSCC) -o $@ $^

######

pkgreloc:: ; $(PATSOPT) --pkgreloc -d test01.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) test01

###### end of [Makefile] ######