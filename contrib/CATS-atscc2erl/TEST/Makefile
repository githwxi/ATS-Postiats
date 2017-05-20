#
# A Simple Makefile
#

######

ERL=erl
ERLC=erlc

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2ERL=./../atscc2erl
#
LIBATSCC2ERL=\
$(PATSHOME)/contrib/libatscc2erl/ATS2-0.3.2
#
######

all::
regress::
cleanall::

######

all:: \
f91_dats.erl
f91_dats.erl: f91.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
f91_dats.beam:: f91_dats.erl ; $(ERLC) $< 
regress:: f91_dats.beam; $(ERL) -run f91_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) f91_dats.erl

######

all:: \
fact_dats.erl
fact_dats.erl: fact.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
fact_dats.beam:: fact_dats.erl ; $(ERLC) $< 
regress:: fact_dats.beam; $(ERL) -run fact_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) fact_dats.erl

######

all:: \
fact2_dats.erl
fact2_dats.erl: fact2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
fact2_dats.beam:: fact2_dats.erl ; $(ERLC) $< 
regress:: fact2_dats.beam; $(ERL) -run fact2_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) fact2_dats.erl

######

all:: \
fact3_dats.erl
fact3_dats.erl: fact3.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
fact3_dats.beam:: fact3_dats.erl ; $(ERLC) $< 
regress:: fact3_dats.beam; $(ERL) -run fact3_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) fact3_dats.erl

######

all:: \
fact4_dats.erl
fact4_dats.erl: fact4.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
fact4_dats.beam:: fact4_dats.erl ; $(ERLC) $< 
regress:: fact4_dats.beam; $(ERL) -run fact4_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) fact4_dats.erl

######

all:: \
fact5_dats.erl
fact5_dats.erl: fact5.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
fact5_dats.beam:: fact5_dats.erl ; $(ERLC) $< 
regress:: fact5_dats.beam; $(ERL) -run fact5_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) fact5_dats.erl

######

all:: \
acker_dats.erl
acker_dats.erl: acker.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
acker_dats.beam:: acker_dats.erl ; $(ERLC) $< 
regress:: acker_dats.beam; $(ERL) -run acker_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) acker_dats.erl

######

all:: \
isevn_dats.erl
isevn_dats.erl: isevn.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
isevn_dats.beam:: isevn_dats.erl ; $(ERLC) $< 
regress:: isevn_dats.beam; $(ERL) -run isevn_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) isevn_dats.erl

######

all:: \
loop_fnx3_dats.erl
loop_fnx3_dats.erl: loop_fnx3.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
loop_fnx3_dats.beam:: loop_fnx3_dats.erl ; $(ERLC) $< 
regress:: loop_fnx3_dats.beam; $(ERL) -run loop_fnx3_dats mytest -run init stop -noshell
cleanall:: ; $(RMF) loop_fnx3_dats.erl

######

all:: \
queens_dats.erl
queens_dats.erl: queens.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
queens_dats.beam:: queens_dats.erl ; $(ERLC) $< 
regress:: queens_dats.beam; $(ERL) -run queens_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) queens_dats.erl

######

all:: \
listlen_dats.erl
listlen_dats.erl: listlen.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
listlen_dats.beam:: listlen_dats.erl ; $(ERLC) $< 
regress:: listlen_dats.beam; $(ERL) -run listlen_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) listlen_dats.erl

######

all:: \
listmap_dats.erl
listmap_dats.erl: listmap.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
listmap_dats.beam:: listmap_dats.erl ; $(ERLC) $< 
regress:: listmap_dats.beam; $(ERL) -run listmap_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) listmap_dats.erl

######

all:: \
weekday_dats.erl
weekday_dats.erl: weekday.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
weekday_dats.beam:: weekday_dats.erl ; $(ERLC) $< 
regress:: weekday_dats.beam; $(ERL) -run weekday_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) weekday_dats.erl

######

all:: \
rtfind_dats.erl
rtfind_dats.erl: rtfind.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
rtfind_dats.beam:: rtfind_dats.erl ; $(ERLC) $< 
regress:: rtfind_dats.beam; $(ERL) -run rtfind_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) rtfind_dats.erl

######

all:: \
rtfind2_dats.erl
rtfind2_dats.erl: rtfind2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
rtfind2_dats.beam:: rtfind2_dats.erl ; $(ERLC) $< 
regress:: rtfind2_dats.beam; $(ERL) -run rtfind2_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) rtfind2_dats.erl

######

all:: \
twice_dats.erl
twice_dats.erl: twice.dats ; \
$(PATSOPT) -d $< | $(ATSCC2ERL) -o $@
twice_dats.beam:: twice_dats.erl ; $(ERLC) $< 
regress:: twice_dats.beam; $(ERL) -run twice_dats main0_erl -run init stop -noshell
cleanall:: ; $(RMF) twice_dats.erl

######

testall:: all
testall:: libatscc2erl
testall:: regress
testall:: cleanall

######
#
CPF=cp -f
RMF=rm -f
RMRF=rm -rf
#
######
#
libatscc2erl:: ; \
$(CPF) $(LIBATSCC2ERL)/output/libatscc2erl_all.hrl libatscc2erl/.
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.beam
clean:: ; $(RMF) erl_crash.dump

######

cleanall:: clean
cleanall:: ; $(RMF) libatscc2erl/libatscc2erl_all.hrl

###### end of [Makefile] ######
