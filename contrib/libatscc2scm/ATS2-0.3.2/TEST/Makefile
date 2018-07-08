#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSCC2SCM=$(PATSHOME)/bin/atscc2scm

######
#
SCHEME=guile
#
SCHEME2=$(SCHEME) \
  -l ./../output/libatscc2scm_all.scm
#
######

all::
regress::
cleanall::

######

all:: \
test01
test01: test01_dats.scm
regress:: \
test_test01
test_test01: \
test01_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) test01_dats.scm

######

all:: \
test02
test02: test02_dats.scm
regress:: \
test_test02
test_test02: \
test02_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) test02_dats.scm

######

%_dats.scm: %.dats ; $(PATSOPT) -d $< | $(ATSCC2SCM) -o $@

######

testall:: all
testall:: regress
testall:: cleanall

######
#
RMF=rm -f
RMRF=rm -rf
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
