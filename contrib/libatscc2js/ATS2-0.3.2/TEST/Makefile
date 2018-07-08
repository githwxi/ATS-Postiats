#
# A simple Makefile
#
######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2JS=${PATSHOME}/bin/atscc2js

######

MAKE=make
NODEJS=nodejs

######

all::

######
#
all:: \
test01
test01: \
test01_dats.js
test01_dats.c: test01.dats; $(PATSOPT) -o $@ -d $<
test01_dats.js: test01_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: \
test_test01
test_test01: test01_dats.js; $(NODEJS) $<
#
######
#
all:: \
test02_dats.js
test02_dats.c: test02.dats; $(PATSOPT) -o $@ -d $<
test02_dats.js: test02_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: \
test_test02
test_test02: test02_dats.js; $(NODEJS) $<
#
######
#
all:: \
test04_dats.js
test04_dats.c: test04.dats; $(PATSOPT) -o $@ -d $<
test04_dats.js: test04_dats.c; $(ATSCC2JS) -o $@ -i $<
#
regress:: \
test_test04
test_test04: test04_dats.js; $(NODEJS) $<
#
######

testall:: all
testall:: regress
testall:: cleanall

######

testall:: ; $(MAKE) -C Worker testall
testall:: ; $(MAKE) -C BUCS320/GraphSearch testall

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
