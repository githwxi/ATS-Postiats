######
#
# A simple Makefile
#
######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2JS=${PATSHOME}/bin/atscc2js

######

NODEJS=nodejs

######

all::

######

all:: \
test01
test01: \
test01_dats.js
test01_dats.c: \
test01.dats; $(PATSOPT) -o $@ -d $<
test01_dats.js: \
test01_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: \
test_test01
test_test01: test01_dats.js; $(NODEJS) $<
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
cleanall:: ; $(RMF) *_?ats.js

######

###### end of [Makefile] ######
