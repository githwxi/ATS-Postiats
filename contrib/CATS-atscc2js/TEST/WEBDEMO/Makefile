#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2JS=$(PATSHOME)/bin/atscc2js

######

all:: upload_html

######

DATS_JS/mytest_dats.js: mytest.dats; $(PATSOPT) -d $< | $(ATSCC2JS) -o $@ -i

######
#
upload_html: ; \
$(SCP) mytest.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/COMPILED/doc/PROJECT/MEDIUM/CATS-parsemit/JavaScript/.
#
upload_DATS_JS: \
DATS_JS/mytest_dats.js; \
$(SCP) DATS_JS/mytest_dats.js \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/COMPILED/doc/PROJECT/MEDIUM/CATS-parsemit/JavaScript/DATS_JS/.
#
######

SCP=scp
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) DATS_JS/*_dats.js

######

###### end of [Makefile] ######
