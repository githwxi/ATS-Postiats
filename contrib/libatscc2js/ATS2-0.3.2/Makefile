#
# For generating libatscc2js
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2JS=$(PATSHOME)/bin/atscc2js

######

CAT=cat
CPF=cp -f
RMF=rm -f
SCPR=scp -r

######

all::
all_in_one::

######
#
all:: ; \
$(PATSOPT) -d ./DATS/basics.dats | \
$(ATSCC2JS) -o ./output/DATS/basics_dats.js -i
#
all:: ; \
$(PATSOPT) -d ./DATS/char.dats | \
$(ATSCC2JS) -o ./output/DATS/char_dats.js -i
#
all:: ; \
$(PATSOPT) -d ./DATS/string.dats | \
$(ATSCC2JS) -o ./output/DATS/string_dats.js -i
#
all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2JS) -o ./output/DATS/list_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/list_vt.dats | \
$(ATSCC2JS) -o ./output/DATS/list_vt_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2JS) -o ./output/DATS/option_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2JS) -o ./output/DATS/stream_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2JS) -o ./output/DATS/stream_vt_dats.js -i
#
all:: ; \
$(PATSOPT) -d ./DATS/gvalue.dats | \
$(ATSCC2JS) -o ./output/DATS/gvalue_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2JS) -o ./output/DATS/intrange_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/JSarray.dats | \
$(ATSCC2JS) -o ./output/DATS/JSarray_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/reference.dats | \
$(ATSCC2JS) -o ./output/DATS/reference_dats.js -i
#
all:: ; \
$(PATSOPT) -d ./DATS/arrayref.dats | \
$(ATSCC2JS) -o ./output/DATS/arrayref_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/matrixref.dats | \
$(ATSCC2JS) -o ./output/DATS/matrixref_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/gmatrixref.dats | \
$(ATSCC2JS) -o ./output/DATS/gmatrixref_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2JS) -o ./output/DATS/slistref_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2JS) -o ./output/DATS/qlistref_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2JS) -o ./output/DATS/ML/list0_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/array0.dats | \
$(ATSCC2JS) -o ./output/DATS/ML/array0_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/Bacon.js/baconjs.dats | \
$(ATSCC2JS) -o ./output/DATS/Bacon.js/baconjs_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/Bacon.js/baconjs_ext.dats | \
$(ATSCC2JS) -o ./output/DATS/Bacon.js/baconjs_ext_dats.js -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/BUCS320/parcomb/parcomb.dats | \
$(ATSCC2JS) -o ./output/DATS/BUCS320/parcomb/parcomb_dats.js -i
#
######
#
LIBATSCC2JS_ALL_JS=\
output/libatscc2js_all.js
LIBATSCC2JS_BACONJS_ALL_JS=\
output/libatscc2js_baconjs_all.js
LIBATSCC2JS_BUCS320_PARCOMB_JS=\
output/libatscc2js_bucs320_parcomb.js
#
######

all_in_one:: libatscc2js_all
all_in_one:: libatscc2js_baconjs_all
all_in_one:: libatscc2js_bucs320_parcomb

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2js_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2JS_ALL_JS)
#
libatscc2js_all:: ; \
$(PRINTF) '/*\n' | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
libatscc2js_all:: ; \
$(PRINTF) 'Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
libatscc2js_all:: ; \
$(DATE) | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
libatscc2js_all:: ; \
$(PRINTF) '*/\n\n' | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
#
######
#
libatscc2js_all:: ; \
$(CAT) >>$(LIBATSCC2JS_ALL_JS) \
CATS/basics_cats.js \
CATS/integer_cats.js \
CATS/bool_cats.js \
CATS/float_cats.js \
CATS/string_cats.js \
CATS/gvalue_cats.js \
CATS/JSmath_cats.js \
CATS/JSdate_cats.js \
CATS/JSarray_cats.js \
CATS/JSglobal_cats.js \
CATS/Ajax/Ajax_cats.js \
CATS/HTML/canvas-2d/canvas2d_cats.js
#
libatscc2js_all:: ; \
$(CAT) >>$(LIBATSCC2JS_ALL_JS) \
output/DATS/basics_dats.js \
output/DATS/char_dats.js \
output/DATS/string_dats.js \
output/DATS/list_dats.js \
output/DATS/list_vt_dats.js \
output/DATS/option_dats.js \
output/DATS/stream_dats.js \
output/DATS/stream_vt_dats.js \
output/DATS/gvalue_dats.js \
output/DATS/intrange_dats.js \
output/DATS/JSarray_dats.js \
output/DATS/reference_dats.js \
output/DATS/arrayref_dats.js \
output/DATS/matrixref_dats.js \
output/DATS/gmatrixref_dats.js \
output/DATS/qlistref_dats.js \
output/DATS/slistref_dats.js \
output/DATS/ML/list0_dats.js \
output/DATS/ML/array0_dats.js
#
######
#
libatscc2js_all:: ; \
$(PRINTF) '\n/* ****** ****** */\n' | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
libatscc2js_all:: ; \
$(PRINTF) '\n/* end of [libatscc2js_all.js] */\n' | $(CAT) - >>$(LIBATSCC2JS_ALL_JS)
#
######
#
libatscc2js_baconjs_all:: ; \
$(CAT) \
>$(LIBATSCC2JS_BACONJS_ALL_JS) \
CATS/Bacon.js/baconjs_cats.js \
output/DATS/Bacon.js/baconjs_dats.js \
output/DATS/Bacon.js/baconjs_ext_dats.js
#
######
#
libatscc2js_bucs320_parcomb:: ; \
$(CAT) \
>$(LIBATSCC2JS_BUCS320_PARCOMB_JS) \
output/DATS/BUCS320/parcomb/parcomb_dats.js
#
######
#
# upload_source:: ; \
# $(SCPR) \
# basics_js.sats \
# staloadall.hats \
# CATS SATS DATS \
# ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2js/.
#
# upload_libatscc2js:: ; \
# $(SCPR) \
# $(LIBATSCC2JS_ALL_JS) \
# $(LIBATSCC2JS_BACONJS_ALL_JS) \
# $(LIBATSCC2JS_BUCS320_PARCOMB_JS) \
# ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2js/.
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) $(LIBATSCC2JS_ALL_JS)
cleanall:: ; $(RMF) $(LIBATSCC2JS_BACONJS_ALL_JS)
cleanall:: ; $(RMF) $(LIBATSCC2JS_BUCS320_PARCOMB_JS)

######

###### end of [Makefile] ######
