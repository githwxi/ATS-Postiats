#
# Makefile for atslangweb/CLIENT
#

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt

######

ATSCC2JS=${PATSHOME}/bin/atscc2js

######

all:: ; \
$(PATSOPT) -d DATS/atslangweb_utils.dats | \
$(ATSCC2JS) -o mycode/atslangweb_utils_dats.js -i

###### end of [Makefile] ######