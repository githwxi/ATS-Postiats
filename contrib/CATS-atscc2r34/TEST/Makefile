######
#
# A Simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2R34=./../atscc2r34
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

%_dats.R: %.dats ; \
$(PATSOPT) -d $< | $(ATSCC2R34) -o $@

######

libatscc2r34:: ; \
$(CPRF) $(LIBATSCC2R34)/CATS ./libatscc2r34/.

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
