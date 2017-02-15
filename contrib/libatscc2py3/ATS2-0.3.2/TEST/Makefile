#
# A Simple Makefile
#

######
#
PYTHON=python3
export PYTHONPATH=./../output
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSCC2PY=$(PATSHOME)/bin/atscc2py3

######

all::
regress::
cleanall::

######

all:: \
test01
test01: test01_dats.py
regress:: \
test_test01
test_test01: \
test01_dats.py ; $(PYTHON) $<
cleanall:: ; $(RMF) test01_dats.py

######

all:: \
test02
test02: test02_dats.py
regress:: \
test_test02
test_test02: \
test02_dats.py ; $(PYTHON) $<
cleanall:: ; $(RMF) test02_dats.py

######

%_dats.py: %.dats ; $(PATSOPT) -d $< | $(ATSCC2PY) -o $@

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
