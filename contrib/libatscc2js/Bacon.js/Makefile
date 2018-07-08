######
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
$(PATSOPT) -d ./DATS/baconjs.dats | \
$(ATSCC2JS) -o ./output/DATS/baconjs_dats.js -i
all:: ; \
$(PATSOPT) -d ./DATS/baconjs_ext.dats | \
$(ATSCC2JS) -o ./output/DATS/baconjs_ext_dats.js -i
#
######

LIBATSCC2JS_BACONJS_ALL_JS=\
output/libatscc2js_baconjs_all.js

######
#

all_in_one:: \
libatscc2js_baconjs_all
libatscc2js_baconjs_all:: ; \
$(CAT) \
>$(LIBATSCC2JS_BACONJS_ALL_JS) \
CATS/baconjs_cats.js \
output/DATS/baconjs_dats.js \
output/DATS/baconjs_ext_dats.js \

#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) output/DATS/*_dats.js
cleanall:: ; $(RMF) $(LIBATSCC2JS_BACONJS_ALL_JS)

######

###### end of [Makefile] ######
