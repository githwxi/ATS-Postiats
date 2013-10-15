#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fact.js

######

PATSCCOMP2=\
"emcc -Wno-warn-absolute-paths -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

######

fact.js: \
  fact.dats ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) \
     --pre-js fact_pre.js \
     --js-library ${PATSHOME}/contrib/HTML/JS/HTMLdocument.js \
     --js-library ${PATSHOME}/contrib/HTML/canvas-2d/JS/HTML5canvas2d.js \
     -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -o $@ $<
cleanall:: ; $(RMF) fact.js
cleanall:: ; $(RMF) fact.js.map

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *.map

######

cleanall:: clean

###### end of [Makefile] ######
