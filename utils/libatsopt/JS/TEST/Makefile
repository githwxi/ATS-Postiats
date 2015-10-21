#
# A simple Makefile
#
######

CC=emcc
CCOMP=$(CC)
JS_TYPE=BROWSER

######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######

CFLAGS += -Wno-implicit-function-declaration

######

all:: patsopt_dats.js

######

ifeq ($(JS_TYPE),NODEJS)
patsopt_dats.js: patsopt_dats.c ; \
$(CCOMP) \
  -O2 $(CFLAGS) \
  -I$(ATSHOME) \
  -I$(ATSRUNTIME) \
  -DJS_TYPE=$(JS_TYPE) \
  --pre-js ./../setup.js \
  -s ASSERTIONS=1 \
  -s EXPORTED_FUNCTIONS="['_main']" \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
endif
ifeq ($(JS_TYPE),BROWSER)
patsopt_dats.js: patsopt_dats.c ; \
$(CCOMP) \
  -O2 $(CFLAGS) \
  -I$(ATSHOME) \
  -I$(ATSRUNTIME) \
  -DJS_TYPE=$(JS_TYPE) \
  --pre-js ./../setup.js \
  --preload-file ./PATSHOME@/PATSHOME \
  -s ASSERTIONS=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s EXPORTED_FUNCTIONS="['_main']" \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
endif

######
#
ifeq ($(JS_TYPE),BROWSER)
patsopt_ccomp.html: patsopt_ccomp_dats.c ; \
$(CCOMP) \
  -O2 $(CFLAGS) \
  -I$(ATSHOME) \
  -I$(ATSRUNTIME) \
  -DJS_TYPE=$(JS_TYPE) \
  --pre-js ./../setup.js \
  --preload-file ./PATSHOME@/PATSHOME \
  -s ASSERTIONS=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s EXPORTED_FUNCTIONS="['_main']" \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
endif
#
######
#
%_sats.c: %.sats ; $(ATSOPT) -o $@ --static $<
%_dats.c: %.dats ; $(ATSOPT) -o $@ --dynamic $<
#
######

NODEJS=nodejs

######
#
# For testing [patsopt_dats.js]
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/filebas.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/intrange.dats 
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/list.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/list_vt.dats 
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/option.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/option_vt.dats 
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/array.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/arrayptr.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/arrayref.dats 
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/matrix.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/matrixptr.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/matrixref.dats 
#
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/stream.dats 
test_patsopt:: ; \
$(NODEJS) patsopt_dats.js --dynamic /PATSHOME/prelude/DATS/stream_vt.dats 
#
######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f patsopt_dats.js
cleanall:: ; rm -f patsopt_dats.data
cleanall:: ; rm -f patsopt_dats.js.mem
cleanall:: ; rm -f patsopt_ccomp.js
cleanall:: ; rm -f patsopt_ccomp.data
cleanall:: ; rm -f patsopt_ccomp.html
cleanall:: ; rm -f patsopt_ccomp.html.mem

###### end of [Makefile] ######
