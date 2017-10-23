#
# A Simple Makefile
#

######

PERL=perl

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2PL=./../bin/atscc2pl
#
LIBATSCC2PL=\
$(PATSHOME)/contrib/libatscc2pl/ATS2-0.3.2
#
######

all::
cleanall::

######
#
all:: \
fact_dats.pl
fact_dats.pl: fact.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_fact
test_fact:: \
fact_dats.pl ; $(PERL) fact_dats.pl
#
cleanall:: ; $(RMF) fact_dats.pl
#
######
#
all:: \
fact2_dats.pl
fact2_dats.pl: fact2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_fact2
test_fact2:: \
fact2_dats.pl ; $(PERL) fact2_dats.pl
#
cleanall:: ; $(RMF) fact2_dats.pl
#
######
#
all:: \
f91_dats.pl
f91_dats.pl: f91.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_f91
test_f91:: \
f91_dats.pl ; $(PERL) f91_dats.pl 23
#
cleanall:: ; $(RMF) f91_dats.pl
#
######
#
all:: \
acker_dats.pl
acker_dats.pl: acker.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
regress:: \
test_acker
test_acker:: \
acker_dats.pl ; $(PERL) acker_dats.pl
cleanall:: ; $(RMF) acker_dats.pl
#
######
#
all:: \
isevn_dats.pl
isevn_dats.pl: isevn.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_isevn
test_isevn:: \
isevn_dats.pl ; $(PERL) isevn_dats.pl
#
cleanall:: ; $(RMF) isevn_dats.pl
#
######
#
all:: \
queens_dats.pl
queens_dats.pl: queens.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_queens
test_queens:: \
queens_dats.pl ; $(PERL) queens_dats.pl
#
cleanall:: ; $(RMF) queens_dats.pl
#
######
#
all:: \
queens_comb_dats.pl
queens_comb_dats.pl: queens_comb.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_queens_comb
test_queens_comb:: \
queens_comb_dats.pl ; $(PERL) queens_comb_dats.pl
#
cleanall:: ; $(RMF) queens_comb_dats.pl
#
######
#
all:: \
weekday_dats.pl
weekday_dats.pl: weekday.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_weekday
test_weekday:: \
weekday_dats.pl ; $(PERL) weekday_dats.pl
#
cleanall:: ; $(RMF) weekday_dats.pl
#
######
#
all:: \
rtfind_dats.pl
rtfind_dats.pl: rtfind.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_rtfind
test_rtfind:: \
rtfind_dats.pl ; $(PERL) rtfind_dats.pl
#
cleanall:: ; $(RMF) rtfind_dats.pl
#
######
#
all:: \
rtfind2_dats.pl
rtfind2_dats.pl: rtfind2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_rtfind2
test_rtfind2:: \
rtfind2_dats.pl ; $(PERL) rtfind2_dats.pl
#
cleanall:: ; $(RMF) rtfind2_dats.pl
#
######
#
all:: \
listlen_dats.pl
listlen_dats.pl: listlen.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_listlen
test_listlen:: \
listlen_dats.pl ; $(PERL) listlen_dats.pl
#
cleanall:: ; $(RMF) listlen_dats.pl
#
######
#
all:: \
listmap_dats.pl
listmap_dats.pl: listmap.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_listmap
test_listmap:: \
listmap_dats.pl ; $(PERL) listmap_dats.pl
#
cleanall:: ; $(RMF) listmap_dats.pl
#
######
#
all:: \
twice_dats.pl
twice_dats.pl: twice.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_twice
test_twice:: twice_dats.pl ; $(PERL) twice_dats.pl
#
cleanall:: ; $(RMF) twice_dats.pl
#
######
#
all:: \
sieve_lazy_dats.pl
sieve_lazy_dats.pl: sieve_lazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_sieve_lazy
test_sieve_lazy:: \
sieve_lazy_dats.pl ; $(PERL) sieve_lazy_dats.pl
#
cleanall:: ; $(RMF) sieve_lazy_dats.pl
#
######
#
all:: \
sieve_llazy_dats.pl
sieve_llazy_dats.pl: sieve_llazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PL) -o $@
#
regress:: \
test_sieve_llazy
test_sieve_llazy:: \
sieve_llazy_dats.pl ; $(PERL) sieve_llazy_dats.pl
#
cleanall:: ; $(RMF) sieve_llazy_dats.pl
#
######

testall:: all
testall:: libatscc2pl
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
libatscc2pl:: ; \
$(CPF) \
$(LIBATSCC2PL)/output/libatscc2pl_all.pl libatscc2pl/.
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMRF) libatscc2pl/libatscc2pl_all.pl

###### end of [Makefile] ######
