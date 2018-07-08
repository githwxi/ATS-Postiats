#
# A simple Makefile
#

######
#
EMCC=emcc
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
#
######

all:: showfile_dats.js

######
#
showfile_dats.c: \
showfile.dats ; $(PATSOPT) --output $@ --dynamic $<
showfile_mylib_dats.c: \
showfile_mylib.dats ; $(PATSOPT) --output $@ --dynamic $<
#
showfile_dats.js: \
showfile_dats.c \
showfile_mylib_dats.c ; \
$(EMCC) \
  -I${PATSHOME} \
  -I${PATSHOME}/ccomp/runtime \
  -DATS_MEMALLOC_LIBC \
  --pre-js showfile_pre.js \
  --post-js showfile_post.js \
  --preload-file DATA/showfile.html \
  -s EXPORTED_FUNCTIONS="['_showfile_dynload_','_ATSJS_fmore']" \
  -o $@ $^
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
cleanall:: ; $(RMF) showfile_dats.js
cleanall:: ; $(RMF) showfile_dats.data

###### end of [Makefile] ######
