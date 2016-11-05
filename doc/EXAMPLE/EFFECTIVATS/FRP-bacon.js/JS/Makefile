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

clean:: ; rm -f *~

######

cleanall:: clean
cleanall:: ; rm -f *_?ats.c
cleanall:: ; rm -f *_?ats.js

###### end of [Makefile] ######
