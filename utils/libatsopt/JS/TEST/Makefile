#
# A simple Makefile
#
######

CC=emcc
CCOMP=$(CC)

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
#
patsopt_dats.c: patsopt.dats ; \
$(ATSOPT) -o patsopt_dats.c --dynamic $<
#
patsopt_dats.js: patsopt_dats.c ; \
$(CCOMP) $(CFLAGS) \
  -I$(ATSHOME) \
  -I$(ATSRUNTIME) \
  --pre-js ./../setup.js \
  -s ASSERTIONS=2 \
  -s EXPORTED_FUNCTIONS="['_main']" \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
#
# patsopt_dats.js: patsopt_dats.c ; \
# $(CCOMP) \
#   -I$(ATSHOME) \
#   -I$(ATSRUNTIME) \
#   --pre-js ./../setup.js \
#   --preload-file ./PATSHOME@/PATSHOME \
#   -s EXPORTED_FUNCTIONS="['_main']" \
#   -o $@ $(ATSRUNTIME)/ats_prelude.c $< ./../libatsopt_ext.o
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

###### end of [Makefile] ######
