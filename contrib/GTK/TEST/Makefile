#
# A Makefile for GTK tests
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

all:: test00
test00: test00.dats ; $(PATSCC) -I${PATSHOME}/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) test00

all:: test01
test01: test01.dats ; $(PATSCC) -I${PATSHOME}/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) test01

all:: test02
test02: test02.dats ; $(PATSCC) -I${PATSHOME}/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) test02

all:: test03
test03: test03.dats ; $(PATSCC) -I${PATSHOME}/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) test03

all:: test04
test04: test04.dats ; $(PATSCC) -I${PATSHOME}/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) test04

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######

