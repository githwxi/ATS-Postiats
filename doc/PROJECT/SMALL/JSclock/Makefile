#
# A Makefile for a javascript based clock written in ATS.
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc

######
##
## Set the C compiler to be emscripten
##
PATSCCOMP2=\
"emcc -Wno-warn-absolute-paths -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"
##
######

all:: myclock0.js

myclock0.js: myclock0.dats myclock0_lib.js ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) -I${PATSHOME}/contrib \
    --js-library myclock0_lib.js --js-library ${PATSHOME}/contrib/HTML/canvas-2d/JS/HTML5canvas2d.js -o $@ $<

upload_myclock0:: ; scp myclock0.html myclock0.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/JSclock/

######

all:: myclock1.js

myclock1.js: myclock1.dats myclock1_lib.js ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib \
    --js-library myclock1_lib.js --js-library ${PATSHOME}/contrib/HTML/canvas-2d/JS/HTML5canvas2d.js -o $@ $<

upload_myclock1:: ; scp myclock1.html myclock1.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/JSclock/

######

RMF=rm -f

######

.PHONY: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) myclock0_dats.c
clean:: ; $(RMF) myclock1_dats.c

cleanall:: clean
cleanall:: ; $(RMF) myclock0.js myclock0.js.map
cleanall:: ; $(RMF) myclock1.js myclock1.js.map

###### end of [Makefile] ######
