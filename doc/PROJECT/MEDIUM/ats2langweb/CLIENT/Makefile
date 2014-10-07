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
# all:: ; $(CPF) CATS/*.js mycode/.
#
######
#
all:: \
mycode/atslangweb_utils_dats.js
#
DATS/atslangweb_utils_dats.c: \
DATS/atslangweb_utils.dats; $(PATSOPT) -o $@ -d $<
mycode/atslangweb_utils_dats.js: \
DATS/atslangweb_utils_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
mycode/patsoptaas_utils_dats.js
#
DATS/patsoptaas_utils_dats.c: \
DATS/patsoptaas_utils.dats; $(PATSOPT) -o $@ -d $<
mycode/patsoptaas_utils_dats.js: \
DATS/patsoptaas_utils_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
mycode/patsoptaas_examples_dats.js
#
DATS/patsoptaas_examples_dats.c: \
DATS/patsoptaas_examples.dats; $(PATSOPT) -o $@ -d $<
mycode/patsoptaas_examples_dats.js: \
DATS/patsoptaas_examples_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######
#
all:: \
mycode/patsoptaas_templates_dats.js
#
DATS/patsoptaas_templates_dats.c: \
DATS/patsoptaas_templates.dats; $(PATSOPT) -o $@ -d $<
mycode/patsoptaas_templates_dats.js: \
DATS/patsoptaas_templates_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######

clean:: ; $(RMF) DATS/*_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) mycode/atslangweb_utils_dats.js
cleanall:: ; $(RMF) mycode/patsoptaas_utils_dats.js
cleanall:: ; $(RMF) mycode/patsoptaas_examples_dats.js
cleanall:: ; $(RMF) mycode/patsoptaas_templates_dats.js

###### end of [Makefile] ######