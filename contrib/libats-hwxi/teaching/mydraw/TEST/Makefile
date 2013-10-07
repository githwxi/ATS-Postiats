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

all:: test01-cairo
test01-cairo: test01-cairo.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test01-cairo test01.png

######

all:: test01-canvas2d
test01-canvas2d: test01-canvas2d.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -ccats $<

######

all:: test02-cairo
test02-cairo: test02-cairo.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test02-cairo test02.png

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]