#
# A simple Makefile
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

.PHONY: all

######

all:: test01
test01: test01.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test01
cleanall:: ; $(RMF) test01.png

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]