######
#
# A simple Makefile
#
######

PHP=php

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2PHP=${PATSHOME}/bin/atscc2php

######

all::
regress::
cleanall::

######
#
all:: \
test01_dats.php
test01_dats.c: \
test01.dats; $(PATSOPT) -o $@ -d $<
test01_dats.php: \
test01_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
######
#
all:: \
test02_dats.php
test02_dats.c: \
test02.dats; $(PATSOPT) -o $@ -d $<
test02_dats.php: \
test02_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
######
#
all:: \
test03_dats.php
test03_dats.c: \
test03.dats; $(PATSOPT) -o $@ -d $<
test03_dats.php: \
test03_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
######
#
all:: \
test04_dats.php
test04_dats.c: \
test04.dats; $(PATSOPT) -o $@ -d $<
test04_dats.php: \
test04_dats.c; $(ATSCC2PHP) -o $@ -i $<
#
######
#
regress:: test01_dats.php; $(PHP) -f $<
regress:: test02_dats.php; $(PHP) -f $<
regress:: test03_dats.php; $(PHP) -f $<
regress:: test04_dats.php; $(PHP) -f $<
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.php

######

###### end of [Makefile] ######
