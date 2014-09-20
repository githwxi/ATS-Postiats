#
# Makefile for atslangweb/SERVER
#

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt

######

ATSCC2PHP=${PATSHOME}/bin/atscc2php

######

all:: ; \
$(PATSOPT) -d DATS/basics.dats | \
$(ATSCC2PHP) -o mycode/basics_dats.php -i
all:: ; \
$(PATSOPT) -d DATS/atslangweb_utils.dats | \
$(ATSCC2PHP) -o mycode/atslangweb_utils_dats.php -i

###### end of [Makefile] ######
