#
# Makefile for atslangweb/CLIENT
#

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt

######

ATSCC2JS=${PATSHOME}/bin/atscc2js

######

CPF=cp -f
RMF=rm -f

######
#
all:: \
MYCODE/atslangweb_utils_dats.js
#
DATS/atslangweb_utils_dats.c: \
DATS/atslangweb_utils.dats; $(PATSOPT) -o $@ -d $<
MYCODE/atslangweb_utils_dats.js: \
DATS/atslangweb_utils_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
MYCODE/patsoptaas_utils_dats.js
#
DATS/patsoptaas_utils_dats.c: \
DATS/patsoptaas_utils.dats; $(PATSOPT) -o $@ -d $<
MYCODE/patsoptaas_utils_dats.js: \
DATS/patsoptaas_utils_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
MYCODE/patsoptaas_examples_dats.js
#
DATS/patsoptaas_examples_dats.c: \
DATS/patsoptaas_examples.dats; $(PATSOPT) -o $@ -d $<
MYCODE/patsoptaas_examples_dats.js: \
DATS/patsoptaas_examples_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
MYCODE/patsoptaas_templates_dats.js
#
DATS/patsoptaas_templates_dats.c: \
DATS/patsoptaas_templates.dats; $(PATSOPT) -o $@ -d $<
MYCODE/patsoptaas_templates_dats.js: \
DATS/patsoptaas_templates_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######

clean:: ; $(RMF) DATS/*_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) MYCODE/atslangweb_utils_dats.js
cleanall:: ; $(RMF) MYCODE/patsoptaas_utils_dats.js
cleanall:: ; $(RMF) MYCODE/patsoptaas_examples_dats.js
cleanall:: ; $(RMF) MYCODE/patsoptaas_templates_dats.js

###### end of [Makefile] ######
