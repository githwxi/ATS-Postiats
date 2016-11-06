#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2JS=$(PATSHOME)/bin/atscc2js

######

all::

######

all:: \
theCounter_callback_dats.js
theCounter_callback_dats.js: \
theCounter_callback.dats; $(PATSCC) -ccats $<; $(ATSCC2JS) -o $@ -i theCounter_callback_dats.c

######

all:: \
theCounter2_baconjs_dats.js
theCounter2_baconjs_dats.js: \
theCounter2_baconjs.dats; $(PATSCC) -ccats $<; $(ATSCC2JS) -o $@ -i theCounter2_baconjs_dats.c

######

all:: \
theCounter3_baconjs_dats.js
theCounter3_baconjs_dats.js: \
theCounter3_baconjs.dats; $(PATSCC) -ccats $<; $(ATSCC2JS) -o $@ -i theCounter3_baconjs_dats.c

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f *_?ats.js

###### end of [Makefile] ######
