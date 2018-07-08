#
# A Simple Makefile
#

######

ERL=erl
ERLC=erlc

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSOPT2=$(PATSOPT) --tlcalopt-disable

######

ATSCC2ERL=./../../../atscc2erl

######

all::
regress::
cleanall::

######

all:: \
fib_dats.erl
fib_dats.erl: fib.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
fib_dats.beam:: fib_dats.erl ; $(ERLC) $< 
regress:: fib_dats.beam; \
$(ERL) +P 1000000 -run fib_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) fib_dats.erl

######

all:: \
fib2_dats.erl
fib2_dats.erl: fib2.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
fib2_dats.beam:: fib2_dats.erl ; $(ERLC) $< 
regress:: fib2_dats.beam; \
$(ERL) +P 1000000 -run fib2_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) fib2_dats.erl

######

all:: \
fact_dats.erl
fact_dats.erl: fact.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
fact_dats.beam:: fact_dats.erl ; $(ERLC) $< 
regress:: fact_dats.beam; $(ERL) -run fact_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) fact_dats.erl

######

all:: \
sieve_dats.erl
sieve_dats.erl: sieve.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
sieve_dats.beam:: sieve_dats.erl ; $(ERLC) $< 
regress:: sieve_dats.beam; $(ERL) -run sieve_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) sieve_dats.erl

######

all:: \
bitstr_dats.erl
bitstr_dats.erl: bitstr.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
bitstr_dats.beam:: bitstr_dats.erl ; $(ERLC) $< 
regress:: bitstr_dats.beam; $(ERL) -run bitstr_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) bitstr_dats.erl

######

all:: \
queue_dats.erl
queue_dats.erl: queue.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
queue_dats.beam:: queue_dats.erl ; $(ERLC) $< 
regress:: queue_dats.beam; $(ERL) -run queue_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) queue_dats.erl

######

all:: \
queue2_dats.erl
queue2_dats.erl: queue2.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
queue2_dats.beam:: queue2_dats.erl ; $(ERLC) $< 
regress:: queue2_dats.beam; $(ERL) -run queue2_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) queue2_dats.erl

######

all:: \
mergesort_dats.erl
mergesort_dats.erl: mergesort.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
mergesort_dats.beam:: mergesort_dats.erl ; $(ERLC) $< 
regress:: mergesort_dats.beam; $(ERL) -run mergesort_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) mergesort_dats.erl

######

all:: \
mergesort2_dats.erl
mergesort2_dats.erl: mergesort2.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
mergesort2_dats.beam:: mergesort2_dats.erl ; $(ERLC) $< 
regress:: mergesort2_dats.beam; $(ERL) -run mergesort2_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) mergesort2_dats.erl

######
#
# MPST: multi-party session
#
all:: \
MPST_S0B1B2_dats.erl
MPST_S0B1B2_dats.erl: MPST_S0B1B2.dats ; \
$(PATSOPT2) -d $< | $(ATSCC2ERL) -o $@
MPST_S0B1B2_dats.beam:: MPST_S0B1B2_dats.erl ; $(ERLC) $< 
#
# regress:: MPST_S0B1B2_dats.beam; $(ERL) -run MPST_S0B1B2_dats main0_erl -run init stop -noshell
#
cleanall:: ; $(RMF) MPST_S0B1B2_dats.erl
#
######

testall:: all
testall:: regress
testall:: cleanall

######
#
CPF=cp -f
RMF=rm -f
RMRF=rm -rf
#
######

libatscc2erl:: ; \
$(CPF) \
$(PATSCONTRIB)/contrib\
/libatscc/libatscc2erl/output/libatscc2erl_all.hrl libatscc2erl/.

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.beam
clean:: ; $(RMF) erl_crash.dump

######

cleanall:: clean

###### end of [Makefile] ######
