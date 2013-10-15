#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fact.js

######

# LLVM's deadcode optimization is very aggressive. We need to list the
# functions we'll use in Javascript. Passing the switch to patscc
# doesn't work.

PATSCCOMP2=\
"emcc -s EXPORTED_FUNCTIONS=\"['_fact_handle_keypress_fun']\" -Wno-warn-absolute-paths -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

######

fact.js: \
  fact.dats ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) \
     --pre-js fact_pre.js \
     --post-js fact_post.js \
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
