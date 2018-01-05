#
# A simple Makefile
#

######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
Z3=z3
PATSOLVE=./../patsolve_smt2
#
######
#
all:: \
fact
fact:: \
fact_dats.smt2; $(Z3) -smt2 $<
fact_dats.smt2: fact.dats; \
$(PATSOPT) -tc --constraint-export -d $< | \
$(PATSOLVE) -o $@ --println "(set-logic UFNIA)" -i - --println "(exit)"
#
cleanall:: ; $(RMF) fact_dats.smt2
#
######
#
all:: \
fact2
fact2:: \
fact2_dats.smt2; $(Z3) -smt2 $<
fact2_dats.smt2: fact2.dats; \
$(PATSOPT) -tc --constraint-export -d $< | \
$(PATSOLVE) -o $@ --println "(set-logic UFNIA)" -i - --println "(exit)"
#
cleanall:: ; $(RMF) fact2_dats.smt2
#
######
#
all:: \
trigfuns
trigfuns:: \
trigfuns_dats.smt2; $(Z3) -smt2 $<
trigfuns_dats.smt2: trigfuns.dats; \
$(PATSOPT) -tc --constraint-export -d $< | \
$(PATSOLVE) --real-on -o $@ --println "(set-logic AUFNIRA)" -i - --println "(exit)"
#
cleanall:: ; $(RMF) trigfuns_dats.smt2
#
######
#
all:: \
quadratic
quadratic:: \
quadratic_dats.smt2; $(Z3) -smt2 $<
quadratic_dats.smt2: quadratic.dats; \
$(PATSOPT) -tc --constraint-export -d $< | \
$(PATSOLVE) --real-on -o $@ --println "(set-logic AUFNIRA)" -i - --println "(exit)"
#
cleanall:: ; $(RMF) quadratic_dats.smt2
#
######

testall:: all
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
