#
# Makefile for atslangweb/SERVER
#

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt

######

ATSCC2PHP=${PATSHOME}/bin/atscc2php

######

CPF=cp -f
RMF=rm -f

######
#
all:: ; \
$(CPF) CATS/basics_cats.php mycode/.
#
######

all:: \
mycode/basics_dats.php
all:: \
mycode/atslangweb_utils_dats.php
#
DATS/basics_dats.c: \
DATS/basics.dats; $(PATSOPT) -o $@ -d $<
mycode/basics_dats.php: \
DATS/basics_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
DATS/atslangweb_utils_dats.c: \
DATS/atslangweb_utils.dats; $(PATSOPT) -o $@ -d $<
mycode/atslangweb_utils_dats.php: \
DATS/atslangweb_utils_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
######

clean:: ; $(RMF) DATS/*_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) mycode/basics_cats.php
cleanall:: ; $(RMF) mycode/basics_dats.php
cleanall:: ; $(RMF) mycode/atslangweb_utils_dats.php

###### end of [Makefile] ######
