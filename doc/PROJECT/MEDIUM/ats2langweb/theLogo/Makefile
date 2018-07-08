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
INCLUDES=-I$(PATSHOMEQ)/npm-utils/contrib/atscntrb

######

RMF=rm -f

######

all:: \
theLogo
theLogo: \
theLogo.dats ; \
  $(PATSCC) $(INCLUDES) $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
regress:: theLogo; ./$<
cleanall:: ; $(RMF) theLogo

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) theLogo.png

###### end of [Makefile] ######
