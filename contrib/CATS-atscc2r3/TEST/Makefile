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
ATSCC2R3=./../atscc2r3
#
LIBATSCC2R3=\
$(PATSHOME)/contrib/libatscc2r3/ATS2-0.3.2
#
SCHEME2=$(SCHEME) \
-l $(LIBATSCC2R3)/output/libatscc2r3_all.R
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
fact2_dats.R
regress:: \
fact2_dats.R ; $(SCHEME2) $<
cleanall:: ; $(RMF) fact2_dats.R

######

%_dats.R: %.dats ; \
$(PATSOPT) -d $< | $(ATSCC2R3) -o $@

######

libatscc2r3:: ; \
$(CPRF) $(LIBATSCC2R3)/CATS ./libatscc2r3/.

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
cleanall:: ; $(RMRF) libatscc2r3/CATS

###### end of [Makefile] ######
