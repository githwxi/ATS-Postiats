#
# A simple Makefile
#
######

PERL=perl

######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt
ATSCC2PL=${PATSHOME}/bin/atscc2pl

######
#
all:: \
test01
test01: test01_dats.pl
test01_dats.c: test01.dats; $(PATSOPT) -o $@ -d $<
test01_dats.pl: test01_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: test_test01
test_test01: test01_dats.pl; $(PERL) $<
#
######
#
all:: \
test02
test02: test02_dats.pl
test02_dats.c: test02.dats; $(PATSOPT) -o $@ -d $<
test02_dats.pl: test02_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: test_test02
test_test02: test02_dats.pl; $(PERL) $<
#
######
#
all:: \
test03
test03: test03_dats.pl
test03_dats.c: test03.dats; $(PATSOPT) -o $@ -d $<
test03_dats.pl: test03_dats.c; $(ATSCC2PL) -o $@ -i $<
#
regress:: test_test03
test_test03: test03_dats.pl; $(PERL) $<
#
######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.pl

######

###### end of [Makefile] ######
