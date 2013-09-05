#
# A simple Makefile for
# testing the ATS API for cairo
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

XRLIBS=`pkg-config cairo --libs`
XRCFLAGS=`pkg-config cairo --cflags`

######

all::

######

all:: test01

######

all:: test02
all:: test03
all:: test04
all:: test05
all:: cairo-multable

######

cleanall:: ; $(RMF) test01
cleanall:: ; $(RMF) test02
cleanall:: ; $(RMF) test03
cleanall:: ; $(RMF) test04
cleanall:: ; $(RMF) test05
cleanall:: ; $(RMF) cairo-multable

######

%: %.dats ; \
  $(PATSCC) -IIATS $(PATSHOMEQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean
cleanall:: ; $(RMF) *.png
cleanall:: ; $(RMF) cairo-multable.ps

######

###### end of [Makefile] ######
