######
#
# A Simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2R34=./../bin/atscc2r34
#
LIBATSCC2R34=\
$(PATSHOME)/contrib/libatscc2r34
#
######

RSCRIPT=Rscript
RSCRIPT2=$(RSCRIPT)

######

all::
regress::
cleanall::

######

all:: \
fib_dats.R
regress:: \
fib_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) fib_dats.R

######

all:: \
fact_dats.R
regress:: \
fact_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) fact_dats.R

######

all:: \
fact1_dats.R
regress:: \
fact1_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) fact1_dats.R

######

all:: \
fact2_dats.R
regress:: \
fact2_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) fact2_dats.R

######

all:: \
acker_dats.R
regress:: \
acker_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) acker_dats.R

######

all:: \
isevn_dats.R
regress:: \
isevn_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) isevn_dats.R

######

all:: \
listlen_dats.R
regress:: \
listlen_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) listlen_dats.R

######

all:: \
listmap_dats.R
regress:: \
listmap_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) listmap_dats.R

######

all:: \
twice_dats.R
regress:: \
twice_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) twice_dats.R

######

all:: \
rtfind_dats.R
regress:: \
rtfind_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) rtfind_dats.R

all:: \
rtfind2_dats.R
regress:: \
rtfind2_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) rtfind2_dats.R

######

all:: \
sieve_lazy_dats.R
regress:: \
sieve_lazy_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) sieve_lazy_dats.R

######

all:: \
sieve_llazy_dats.R
regress:: \
sieve_llazy_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) sieve_llazy_dats.R

######

all:: \
queens_comb_dats.R
regress:: \
queens_comb_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) queens_comb_dats.R

######

all:: \
queens_simple_dats.R
regress:: \
queens_simple_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) queens_simple_dats.R

######

all:: \
statfuns_dats.R
regress:: \
statfuns_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) statfuns_dats.R

######

all:: \
lms_solve_dats.R
regress:: \
lms_solve_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) lms_solve_dats.R

######

all:: \
cs320-2017-fall-assign04_dats.R
regress:: \
cs320-2017-fall-assign04_dats.R ; $(RSCRIPT2) $<
cleanall:: ; $(RMF) cs320-2017-fall-assign04_dats.R

######

%_dats.R: %.dats ; \
$(PATSOPT) -d $< | $(ATSCC2R34) -o $@

######

libatscc2r34:: ; \
$(CPRF) $(LIBATSCC2R34)/output/libatscc2r34_all.R ./libatscc2r34/.

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
cleanall:: ; $(RMRF) libatscc2r34/CATS

###### end of [Makefile] ######
