######
#
# A Simple Makefile
#
######

NODEJS=nodejs

######
#
ATSCC2JS=./../atscc2js
#
LIBATSCC2JS=\
$(PATSHOME)/contrib/libatscc2js
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::
regress::
cleanall::

######
#
all:: \
fact_dats.js
fact_dats.js: \
fact.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_fact
test_fact:: fact_dats.js ; $(NODEJS) $<
#
cleanall:: ; $(RMF) fact_dats.js
#
######
#
all:: \
fact2_dats.js
fact2_dats.js: fact2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_fact2
test_fact2:: fact2_dats.js ; $(NODEJS) $<
#
cleanall:: ; $(RMF) fact2_dats.js
#
######
#
all:: \
f91_dats.js
f91_dats.js: \
f91.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_f91
test_f91:: f91_dats.js ; $(NODEJS) $< 23
cleanall:: ; $(RMF) f91_dats.js
#
######
#
all:: \
fib_dats.js
fib_dats.js: \
fib.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_fib
test_fib:: fib_dats.js ; $(NODEJS) $< 20
cleanall:: ; $(RMF) fib_dats.js
#
######
#
all:: \
fibats_dats.js
fibats_dats.js: fibats.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_fibats
test_fibats:: fibats_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) fibats_dats.js
#
######

all:: \
acker_dats.js
acker_dats.js: acker.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_acker
test_acker:: acker_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) acker_dats.js

######
#
all:: \
isevn_dats.js
isevn_dats.js: isevn.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_isevn
test_isevn:: isevn_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) isevn_dats.js
#
######
#
all:: \
rtfind_dats.js
rtfind_dats.js: rtfind.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_rtfind
test_rtfind:: rtfind_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) rtfind_dats.js
#
######
#
all:: \
rtfind2_dats.js
rtfind2_dats.js: rtfind2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_rtfind2
test_rtfind2:: rtfind2_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) rtfind2_dats.js
#
######
#
all:: \
listlen_dats.js
listlen_dats.js: listlen.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_listlen
test_listlen:: listlen_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) listlen_dats.js
#
######
#
all:: \
listmap_dats.js
listmap_dats.js: listmap.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_listmap
test_listmap:: listmap_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) listmap_dats.js
#
######
#
all:: \
twice_dats.js
twice_dats.js: twice.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_twice
test_twice:: twice_dats.js ; $(NODEJS) twice_dats.js
cleanall:: ; $(RMF) twice_dats.js
#
######
#
all:: \
queens_comb_dats.js
#
queens_comb_dats.js: \
queens_comb.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: \
test_queens_comb
test_queens_comb:: \
queens_comb_dats.js ; $(NODEJS) $<
#
cleanall:: ; $(RMF) queens_comb_dats.js
#
######
#
all:: \
queens_simple_dats.js
#
queens_simple_dats.js: \
queens_simple.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: \
test_queens_simple
test_queens_simple:: \
queens_simple_dats.js ; $(NODEJS) $<
#
cleanall:: ; $(RMF) queens_simple_dats.js
#
######
#
all:: \
mergesort_dats.js
mergesort_dats.js: mergesort.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_mergesort
test_mergesort:: mergesort_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) mergesort_dats.js
#
######
#
all:: \
sieve_lazy_dats.js
sieve_lazy_dats.js: sieve_lazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_sieve_lazy
test_sieve_lazy:: sieve_lazy_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) sieve_lazy_dats.js
#
######
#
all:: \
sieve_llazy_dats.js
sieve_llazy_dats.js: sieve_llazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: test_sieve_llazy
test_sieve_llazy:: sieve_llazy_dats.js ; $(NODEJS) $<
cleanall:: ; $(RMF) sieve_llazy_dats.js
#
######
#
all:: \
hello_dats.js
hello_dats.c: \
hello.dats ; $(PATSOPT) -o $@ -d $<
hello_dats.js: \
hello_dats.c ; $(ATSCC2JS) -o $@ -i $<
#
regress:: test_hello
test_hello:: hello_dats.js ; $(NODEJS) hello_dats.js
cleanall:: ; $(RMF) hello_dats.js
#
######
#
all:: \
process_test_dats.js
process_test_dats.c: \
process_test.dats ; $(PATSOPT) -o $@ -d $<
process_test_dats.js: \
process_test_dats.c ; $(ATSCC2JS) -o $@ -i $<
process_test:: process_test_dats.js ; $(NODEJS) process_test_dats.js
regress:: process_test
cleanall:: ; $(RMF) process_test_dats.js
#
######

#
all:: \
QueenPuzzle_sol_dats.js
#
QueenPuzzle_sol_dats.js: \
QueenPuzzle_sol.dats ; \
$(PATSOPT) -d $< | $(ATSCC2JS) -o $@
#
regress:: \
test_QueenPuzzle_sol
test_QueenPuzzle_sol:: \
QueenPuzzle_sol_dats.js ; $(NODEJS) $<
#
cleanall:: ; $(RMF) QueenPuzzle_sol_dats.js
#
######

testall:: all
testall:: libatscc2js
testall:: regress
testall:: cleanall

######
#
CPF=cp -f
CPRF=cp -rf
#
RMF=rm -f
RMRF=rm -rf
#
######
#
libatscc2js:: ; \
$(CPF) \
$(LIBATSCC2JS)/output/libatscc2js_all.js libatscc2js/.
#
libatscc2js:: ; \
$(CPRF) $(LIBATSCC2JS)/CATS/* libatscc2js/CATS/.
libatscc2js:: ; \
$(CPRF) $(LIBATSCC2JS)/output/DATS/* libatscc2js/DATS/.
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) libatscc2js/libatscc2js_all.js
cleanall:: ; $(RMRF) libatscc2js/CATS/*
cleanall:: ; $(RMRF) libatscc2js/DATS/*
#
###### end of [Makefile] ######
