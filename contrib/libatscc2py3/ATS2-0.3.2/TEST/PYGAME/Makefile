#
# A simple Makefile
#
######

PYTHON=python3
export PYTHONPATH=./../../output

######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2PY=$(PATSHOME)/bin/atscc2py3
#
######
#
all:: \
test01_dats.py
test01_dats.c: test01.dats; $(PATSOPT) -o $@ -d $<
test01_dats.py: test01_dats.c; $(ATSCC2PY) -o $@ -i $<
#
regress:: \
test01_dats.py; $(PYTHON) $<
#
cleanall:: ; $(RMF) test01_dats.py
#
######

testall:: all
testall:: regress
testall:: cleanall

######

CAT=cat
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
###### end of [Makefile] ######
