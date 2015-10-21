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

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2JS=$(PATSHOME)/bin/atscc2js

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
LIBATSOPT_EXPORTS = '_libatsopt_dynloadall'
#
LIBATSOPT_EXPORTS += , '_libatsopt_patsopt_main'
#
LIBATSOPT_EXPORTS += , '_libatsopt_comarg_strlit'
LIBATSOPT_EXPORTS += , '_libatsopt_comarg_strinp'
LIBATSOPT_EXPORTS +=, '_libatsopt_comarg_prefil'
LIBATSOPT_EXPORTS +=, '_libatsopt_comarg_postfil'
#
LIBATSOPT_EXPORTS +=, '_libatsopt_comarglst_nil'
LIBATSOPT_EXPORTS +=, '_libatsopt_comarglst_cons'
#
LIBATSOPT_EXPORTS +=, '_libatsopt_patsoptres_get_nerr'
LIBATSOPT_EXPORTS +=, '_libatsopt_patsoptres_get_stdout'
LIBATSOPT_EXPORTS +=, '_libatsopt_patsoptres_get_stderr'
#
LIBATSOPT_EXPORTS +=, '_libatsopt_patsopt_main_arglst'
LIBATSOPT_EXPORTS +=, '_libatsopt_patsoptres_main_arglst'
#
libatsopt_ext.js: ; \
$(CCOMP) \
  $(CFLAGS) \
  -I$(ATSHOME) \
  -I$(ATSRUNTIME) \
  --pre-js ./libatsopt_pre.js \
  --preload-file ./PATSHOME@/PATSHOME \
  -s ASSERTIONS=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s EXPORTED_FUNCTIONS="[$(LIBATSOPT_EXPORTS)]" \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
#
######

test_libatsopt_dats.c: \
test_libatsopt.dats; $(PATSOPT) -o $@ -d $<
test_libatsopt_dats.js: \
test_libatsopt_dats.c; $(ATSCC2JS) -o $@ -i $<

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
cleanall:: ; rm -f libatsopt_ext.js
cleanall:: ; rm -f libatsopt_ext.data
cleanall:: ; rm -f libatsopt_ext.js.mem
cleanall:: ; rm -f test_libatsopt_dats.js

###### end of [Makefile] ######
