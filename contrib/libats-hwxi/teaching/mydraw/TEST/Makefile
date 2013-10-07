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

PATSCCOMP2=emcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

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

test01-canvas2d.js: test01-canvas2d.dats ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" --js-library ../JS/mydraw_html5_canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test01-canvas2d.js

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