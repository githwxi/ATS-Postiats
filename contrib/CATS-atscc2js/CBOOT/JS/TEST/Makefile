#
# A simple Makefile
#
######

CC=emcc
CCOMP=$(CC)

######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
#
LIBATSCC2JS_ALL_JS=\
$(PATSHOME)/contrib/libatscc2js/ATS2-0.3.2/output/libatscc2js_all.js
#
######

PATSRUNTIME=$(PATSHOME)/ccomp/runtime

######

CFLAGS += -Wno-implicit-function-declaration

######

all::

######

all:: test_libatscc2js
test_libatscc2js:: libatscc2js_ext.js
test_libatscc2js:: test_libatscc2js_dats.js

all:: wktest_libatscc2js
wktest_libatscc2js:: libatscc2js_ext_worker.js
wktest_libatscc2js:: wktest_libatscc2js_dats.js

######
#
LIBATSCC2JS_EXPORTS = '_libatscc2js_dynload'
#
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarg_strlit'
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarg_strinp'
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarg_prefil'
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarg_postfil'
#
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarglst_nil'
LIBATSCC2JS_EXPORTS += , '_libatscc2js_comarglst_cons'
#
LIBATSCC2JS_EXPORTS += , '_libatscc2js_atscc2js_main0_arglst'
#
libatscc2js_ext.js: ; \
$(CCOMP) \
  -I$(PATSHOME) \
  -I$(PATSRUNTIME) \
  --pre-js ./libatscc2js_pre.js \
  --preload-file ./ATSCC2JS@/ATSCC2JS \
  -s ASSERTIONS=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s EXPORTED_FUNCTIONS="[$(LIBATSCC2JS_EXPORTS)]" \
  -O2 $(CFLAGS) -o $@ ./../libatscc2js_ext.o
#
libatscc2js_ext_worker.js: \
libatscc2js_pre.js \
libatscc2js_worker_dats.js ; \
$(CCOMP) \
  -I$(PATSHOME) \
  -I$(PATSRUNTIME) \
  --pre-js ./libatscc2js_io.js \
  --pre-js ./libatscc2js_pre.js \
  --pre-js ${LIBATSCC2JS_ALL_JS} \
  --post-js ./libatscc2js_worker_dats.js \
  --preload-file ./ATSCC2JS@/ATSCC2JS \
  -s ASSERTIONS=1 \
  -s ALLOW_MEMORY_GROWTH=1 \
  -s EXPORTED_FUNCTIONS="[$(LIBATSCC2JS_EXPORTS)]" \
  -O2 $(CFLAGS) -o $@ ./../libatscc2js_ext.o
#
######

test_libatscc2js_dats.c: \
test_libatscc2js.dats; $(PATSOPT) -o $@ -d $<
test_libatscc2js_dats.js: \
test_libatscc2js_dats.c; $(ATSCC2JS) -o $@ -i $<

######
#
libatscc2js_worker_dats.c: \
libatscc2js_worker.dats; $(PATSOPT) -o $@ -d $<
libatscc2js_worker_dats.js: \
libatscc2js_worker_dats.c; $(ATSCC2JS) -o $@ -i $<
#
wktest_libatscc2js_dats.c: \
wktest_libatscc2js.dats; $(PATSOPT) -o $@ -d $<
wktest_libatscc2js_dats.js: \
wktest_libatscc2js_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
%_sats.c: %.sats ; $(ATSCC2JS) -o $@ --static $<
%_dats.c: %.dats ; $(ATSCC2JS) -o $@ --dynamic $<
#
######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; rm -f libatscc2js_ext.js
cleanall:: ; rm -f libatscc2js_ext.data
cleanall:: ; rm -f libatscc2js_ext.js.mem
cleanall:: ; rm -f libatscc2js_ext_worker.js
cleanall:: ; rm -f libatscc2js_ext_worker.data
cleanall:: ; rm -f libatscc2js_ext_worker.js.mem
#
cleanall:: ; rm -f libatscc2js_worker_dats.js
#
cleanall:: ; rm -f test_libatscc2js_dats.js
cleanall:: ; rm -f wktest_libatscc2js_dats.js
#
###### end of [Makefile] ######
