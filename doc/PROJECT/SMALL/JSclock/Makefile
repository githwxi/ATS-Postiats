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
PATSCCOMP2=emcc -Wno-warn-absolute-paths -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime
##
######

all:: myclock0.js

myclock0.js: myclock0.dats myclock0_lib.js ; \
  $(PATSCC) -atsccomp "$(PATSCCOMP2)" -I${PATSHOME}/contrib \
    --js-library myclock0_lib.js --js-library ${PATSHOME}/contrib/HTML5/canvas-2d/JS/HTMLcanvas2d.js -o $@ $<

upload_myclock0:: ; scp myclock0.html myclock0.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/JSclock/

######

RMF=rm -f

######

.PHONY: clean

clean:: ; $(RMF) myclock0_dats.c

cleanall:: clean
cleanall:: ; $(RMF) myclock0.js myclock0.js.map

###### end of [Makefile] ######
