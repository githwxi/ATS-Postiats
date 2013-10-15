#
# A simple Makefile
#

######

EMCC=emcc
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: fact.js

######

fact.js: fact_dats.c ; \
  $(EMCC) \
    -s EXPORTED_FUNCTIONS="['_ATSJS_fact_handle_keypress_fun']" \
    -Wno-warn-absolute-paths \
    -I${PATSHOME} -I${PATSHOME}/ccomp/runtime \
    --pre-js fact_pre.js \
    --post-js fact_post.js \
    --js-library ${PATSHOME}/contrib/HTML/JS/HTMLdocument.js \
    -o $@ $<
fact_dats.c: fact.dats ; \
  $(PATSOPT) -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib --output $@ --dynamic $<
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
