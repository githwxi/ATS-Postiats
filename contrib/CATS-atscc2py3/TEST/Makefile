#
# A Simple Makefile
#

######
#
PYTHON=python3
#
export \
PYTHONPATH=libatscc2py3/.
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2PY=./../atscc2py3
#
LIBATSCC2PY3=\
$(PATSHOME)/contrib/libatscc2py3/ATS2-0.3.2
#
######

all::
regress::
cleanall::

######
#
RMF=rm -f
RMRF=rm -rf
#
CPF=cp -f
CPRF=cp -rf
#
######
#
all:: \
fact_dats.py
fact_dats.py: \
  fact.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_fact:: fact_dats.py ; $(PYTHON) $<
#
regress:: test_fact
cleanall:: ; $(RMF) fact_dats.py
#
######
#
all:: \
fact2_dats.py
fact2_dats.py: \
  fact2.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_fact2:: \
  fact2_dats.py ; $(PYTHON) $< 10
#
regress:: test_fact2
cleanall:: ; $(RMF) fact2_dats.py
#
######
#
all:: \
f91_dats.py
f91_dats.py: \
  f91.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_f91:: f91_dats.py ; $(PYTHON) $< 23
#
regress:: test_f91
cleanall:: ; $(RMF) f91_dats.py
#
######
#
all:: \
fib_dats.py
fib_dats.py: \
  fib.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_fib:: fib_dats.py ; $(PYTHON) $< 100
#
regress:: test_fib
cleanall:: ; $(RMF) fib_dats.py
#
######
#
all:: \
fibats_dats.py
fibats_dats.py: \
  fibats.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_fibats:: fibats_dats.py ; $(PYTHON) $< 100
#
regress:: test_fibats
cleanall:: ; $(RMF) fibats_dats.py
#
######
#
all:: \
acker_dats.py
acker_dats.py: \
  acker.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_acker:: \
  acker_dats.py ; $(PYTHON) acker_dats.py 3 3
#
regress:: test_acker
cleanall:: ; $(RMF) acker_dats.py
#
######
#
all:: \
isevn_dats.py
isevn_dats.py: \
  isevn.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_isevn:: \
  isevn_dats.py ; $(PYTHON) isevn_dats.py 100
#
regress:: test_isevn
cleanall:: ; $(RMF) isevn_dats.py
#
######
#
all:: \
weekday_dats.py
weekday_dats.py: \
  weekday.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_weekday:: weekday_dats.py ; $(PYTHON) $<
#
regress:: test_weekday
cleanall:: ; $(RMF) weekday_dats.py
#
######
#
all:: \
rtfind_dats.py
rtfind_dats.py: \
  rtfind.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_rtfind:: rtfind_dats.py ; $(PYTHON) $<
#
regress:: test_rtfind
cleanall:: ; $(RMF) rtfind_dats.py
#
######
#
all:: \
rtfind2_dats.py
rtfind2_dats.py: \
  rtfind2.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_rtfind2:: rtfind2_dats.py ; $(PYTHON) $<
#
regress:: test_rtfind2
cleanall:: ; $(RMF) rtfind2_dats.py
#
######
#
all:: \
listlen_dats.py
listlen_dats.py: \
  listlen.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_listlen:: listlen_dats.py ; $(PYTHON) $<
#
regress:: test_listlen
cleanall:: ; $(RMF) listlen_dats.py
#
######
#
all:: \
listmap_dats.py
listmap_dats.py: \
  listmap.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_listmap:: listmap_dats.py ; $(PYTHON) $<
#
regress:: test_listmap
cleanall:: ; $(RMF) listmap_dats.py
#
######
#
all:: \
twice_dats.py
twice_dats.py: \
  twice.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_twice:: twice_dats.py ; $(PYTHON) $<
#
regress:: test_twice
cleanall:: ; $(RMF) twice_dats.py
#
######
#
all:: \
queens_comb_dats.py
queens_comb_dats.py: \
  queens_comb.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
#
test_queens_comb:: queens_comb_dats.py ; $(PYTHON) $<
#
regress:: test_queens_comb
cleanall:: ; $(RMF) queens_comb_dats.py
#
######
#
all:: \
queens_simple_dats.py
queens_simple_dats.py: \
  queens_simple.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@
test_queens_simple:: queens_simple_dats.py ; $(PYTHON) $<
#
regress:: test_queens_simple
cleanall:: ; $(RMF) queens_simple_dats.py
#
######
#
all:: \
PYlist_test_dats.py
PYlist_test_dats.py: \
  PYlist_test.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@ -i
#
test_PYlist_test:: \
  PYlist_test_dats.py ; $(PYTHON) PYlist_test_dats.py
#
regress:: test_PYlist_test
cleanall:: ; $(RMF) PYlist_test_dats.py
#
######
#
all:: \
refcount_dats.py
refcount_dats.py: \
  refcount.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@ -i
#
test_refcount:: \
  refcount_dats.py ; $(PYTHON) refcount_dats.py
#
regress:: test_refcount
cleanall:: ; $(RMF) refcount_dats.py
#
######
#
all:: \
sieve_lazy_dats.py
sieve_lazy_dats.py: \
  sieve_lazy.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@ -i
#
test_sieve_lazy:: \
  sieve_lazy_dats.py ; $(PYTHON) sieve_lazy_dats.py
#
regress:: test_sieve_lazy
cleanall:: ; $(RMF) sieve_lazy_dats.py
#
######
#
all:: \
sieve_llazy_dats.py
sieve_llazy_dats.py: \
  sieve_llazy.dats ; \
  $(PATSOPT) -d $< | $(ATSCC2PY) -o $@ -i
#
test_sieve_llazy:: \
  sieve_llazy_dats.py ; $(PYTHON) sieve_llazy_dats.py
#
regress:: test_sieve_llazy
cleanall:: ; $(RMF) sieve_llazy_dats.py
#

######

testall:: all
testall:: libatscc2py3
testall:: regress
testall:: cleanall

######
#
libatscc2py3:: ; \
$(CPF) \
$(LIBATSCC2PY3)/output/libatscc2py3_all.py libatscc2py3/.
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) *_?ats.py
cleanall:: ; $(RMF) libatscc2py3/libatscc2py3_all.py
cleanall:: ; $(RMRF) libatscc2py3/__pycache__
#
###### end of [Makefile] ######
