######
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
ATSCC2R34=./../atscc2r34
#
LIBATSCC2R34=\
$(PATSHOME)/contrib/libatscc2r34
#
SCHEME2=$(SCHEME) \
-l $(LIBATSCC2R34)/output/libatscc2r34_all.R
#
######

all::
regress::
cleanall::

######

all:: \
fact_dats.R
regress:: \
fact_dats.R ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact_dats.R

######

all:: \
fact1_dats.R
regress:: \
fact1_dats.R ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact1_dats.R

######

all:: \
fact2_dats.R
regress:: \
fact2_dats.R ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact2_dats.R

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
