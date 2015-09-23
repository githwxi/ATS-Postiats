#
# A simple Makefile
#

######

EMCC=emcc
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fact_dats.js

######
#
fact_dats.js: fact_dats.c ; \
$(EMCC) \
  -s EXPORTED_FUNCTIONS="['_ATSJS_fact_handle_keypress_']" \
  -Wno-warn-absolute-paths \
  -I${PATSHOME} -I${PATSHOME}/ccomp/runtime \
  --pre-js fact_pre.js --post-js fact_post.js \
  --js-library ${PATSHOMERELOC}/contrib/HTML-emscripten/JS/HTMLdocument.js \
  -o $@ $<
#
fact_dats.c: fact.dats ; $(PATSOPT) -DATS_MEMALLOC_LIBC --output $@ --dynamic $<
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *.map
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) fact_dats.js

###### end of [Makefile] ######
