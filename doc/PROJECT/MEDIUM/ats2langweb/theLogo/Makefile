#
# A simple Makefile for
# testing the ATS API for cairo
#

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

XRLIBS=`pkg-config cairo --libs`
XRCFLAGS=`pkg-config cairo --cflags`

######

RMF=rm -f

######

all:: \
theLogo
theLogo: \
theLogo.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
regress:: theLogo; ./$<
cleanall:: ; $(RMF) theLogo

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) theLogo.png

###### end of [Makefile] ######
