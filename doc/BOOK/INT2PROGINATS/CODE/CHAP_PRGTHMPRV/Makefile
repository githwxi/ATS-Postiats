#
# A simple Makefile
#

######

CCOPT=gcc -std=c99
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSCCFLAGS=-O2

######

all:: misc
all:: matget
all:: ifact
all:: ifact23
all:: test_fastexp

######

misc: misc.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) misc

######

matget: matget.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) matget

######

ifact: ifact.dats ; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) ifact

ifact23: ifact23.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) ifact23

######

test_fastexp: \
  fastexp.sats fastexp.dats test_fastexp.dats ; \
  $(PATSCC) $(ATSCCFLAGS) -o $@ fastexp.dats test_fastexp.dats
cleanall:: ; $(RMF) test_fastexp

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
