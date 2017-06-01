#
# A simple Makefile
#

######

EMCC=emcc

######

PATSHOMEQ="$(PATSHOME)"
PATSCONTRIBQ="$(PATSHOME)/npm-utils/contrib"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

XRLIBS=`pkg-config cairo --libs`
XRCFLAGS=`pkg-config cairo --cflags`

######

.PHONY: all

######

all::
regress::
cleanall::

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) -I$(PATSCONTRIBQ) $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
regress:: test00; ./$<
cleanall:: ; $(RMF) test00
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile]
