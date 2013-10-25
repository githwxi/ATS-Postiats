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

PATSCCOMP2=emcc -Wno-warn-absolute-paths -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

######

XRLIBS=`pkg-config cairo --libs`
XRCFLAGS=`pkg-config cairo --cflags`

######

.PHONY: all

######

all:: test01-cairo
test01-cairo: \
  test01-cairo.dats test01.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test01-cairo test01.png

######

test01-canvas2d.js: \
  test01-canvas2d.dats test01.dats ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" --js-library ../JS/mydraw_HTML5_canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test01-canvas2d.js
cleanall:: ; $(RMF) test01-canvas2d.js.map
upload_test01:: ; scp test01.html test01-canvas2d.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/mydraw/

######

all:: test02-cairo
test02-cairo: test02-cairo.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test02-cairo test02.png

######

test02-canvas2d.js: \
  test02-canvas2d.dats test02.dats ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" --js-library ../JS/mydraw_HTML5_canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test02-canvas2d.js
cleanall:: ; $(RMF) test02-canvas2d.js.map
upload_test02:: ; scp test02.html test02-canvas2d.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/mydraw/

######

all:: test03-cairo
test03-cairo: \
  test03-cairo.dats test03.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test03-cairo test03.png

######

test03-canvas2d.js: \
  test03-canvas2d.dats test03.dats ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" --js-library ../JS/mydraw_HTML5_canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test03-canvas2d.js
cleanall:: ; $(RMF) test03-canvas2d.js.map
upload_test03:: ; scp test03.html test03-canvas2d.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/mydraw/

######

all:: test04-cairo
test04-cairo: \
  test04-cairo.dats test04.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib $(XRCFLAGS) -o $@ $< $(XRLIBS) -lm 
cleanall:: ; $(RMF) test04-cairo test04.png

######

test04-canvas2d.js: \
  test04-canvas2d.dats test04.dats ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" --js-library ../JS/mydraw_HTML5_canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test04-canvas2d.js
cleanall:: ; $(RMF) test04-canvas2d.js.map
upload_test04:: ; scp test04.html test04-canvas2d.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/mydraw/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]
