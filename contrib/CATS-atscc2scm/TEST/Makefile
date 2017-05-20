#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
SCHEME=guile
#
######
#
ATSCC2SCM=./../atscc2scm
#
LIBATSCC2SCM=\
$(PATSHOME)/contrib/libatscc2scm/ATS2-0.3.2
#
SCHEME2=$(SCHEME) \
-l $(LIBATSCC2SCM)/output/libatscc2scm_all.scm
#
######

all::
regress::
cleanall::

######

all:: \
f91_dats.scm
regress:: \
f91_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) f91_dats.scm

######

all:: \
fact_dats.scm
regress:: \
fact_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact_dats.scm

######

all:: \
fact2_dats.scm
regress:: \
fact2_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact2_dats.scm

######

all:: \
fact3_dats.scm
regress:: \
fact3_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact3_dats.scm

######

all:: \
fact4_dats.scm
regress:: \
fact4_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact4_dats.scm

######

all:: \
acker_dats.scm
regress:: \
acker_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) acker_dats.scm

######

all:: \
isevn_dats.scm
regress:: \
isevn_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) isevn_dats.scm

######

all:: \
loop_fnx3_dats.scm
regress:: \
loop_fnx3_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) loop_fnx3_dats.scm

######
#
all:: \
rtfind_dats.scm
regress:: \
rtfind_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) rtfind_dats.scm
#
all:: \
rtfind2_dats.scm
regress:: \
rtfind2_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) rtfind2_dats.scm
#
######
#
all:: \
twice_dats.scm
regress:: \
twice_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) twice_dats.scm
#
######

all:: \
queens_dats.scm
regress:: \
queens_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) queens_dats.scm

######

all:: \
listlen_dats.scm
regress:: \
listlen_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) listlen_dats.scm

######

all:: \
listmap_dats.scm
regress:: \
listmap_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) listmap_dats.scm

######
#
all:: \
weekday_dats.scm
regress:: \
weekday_dats.scm ; $(SCHEME2) $<
cleanall:: ; $(RMF) weekday_dats.scm
#
######
#
all:: \
sieve_lazy_dats.scm
test_sieve_lazy:: \
sieve_lazy_dats.scm ; $(SCHEME2) $<
regress:: test_sieve_lazy
cleanall:: ; $(RMF) sieve_lazy_dats.scm
#
######
#
all:: \
sieve_llazy_dats.scm
test_sieve_llazy:: \
sieve_llazy_dats.scm ; $(SCHEME2) $<
regress:: test_sieve_llazy
cleanall:: ; $(RMF) sieve_llazy_dats.scm
#
######

%_dats.scm: %.dats ; \
$(PATSOPT) -d $< | $(ATSCC2SCM) -o $@

######

libatscc2scm:: ; \
$(CPRF) $(LIBATSCC2SCM)/CATS ./libatscc2scm/.

######

testall:: all
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

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMRF) libatscc2scm/CATS

###### end of [Makefile] ######
