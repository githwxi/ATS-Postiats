#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2CLJ=./../atscc2clj
#
LIBATSCC2CLJ=\
$(PATSHOME)/contrib/libatscc2clj/ATS2-0.3.2
#
######

######
#
JAVA=java
#
CLOJURE=\
$(JAVA) -Xss4m \
  -cp /usr/share/java/clojure-1.4.jar
#
CLOJURE2=\
$(CLOJURE) clojure.main \
-i $(LIBATSCC2CLJ)/output/libatscc2clj_all.clj
#
######

all::
regress::
cleanall::

######

all:: \
f91_dats.clj
regress:: \
f91_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) f91_dats.clj

######

all:: \
fact_dats.clj
regress:: \
fact_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) fact_dats.clj

######

all:: \
fact2_dats.clj
regress:: \
fact2_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) fact2_dats.clj

######

all:: \
fact3_dats.clj
regress:: \
fact3_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) fact3_dats.clj

######

all:: \
fact4_dats.clj
regress:: \
fact4_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) fact4_dats.clj

######

all:: \
acker_dats.clj
regress:: \
acker_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) acker_dats.clj

######

all:: \
isevn_dats.clj
regress:: \
isevn_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) isevn_dats.clj

######

all:: \
loop_fnx3_dats.clj
regress:: \
loop_fnx3_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) loop_fnx3_dats.clj

######
#
all:: \
rtfind_dats.clj
regress:: \
rtfind_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) rtfind_dats.clj
#
all:: \
rtfind2_dats.clj
regress:: \
rtfind2_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) rtfind2_dats.clj
#
######
#
all:: \
twice_dats.clj
regress:: \
twice_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) twice_dats.clj
#
######

all:: \
queens_comb_dats.clj
regress:: \
queens_comb
queens_comb: \
queens_comb_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) queens_comb_dats.clj

######

all:: \
queens_simple_dats.clj
regress:: \
queens_simple_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) queens_simple_dats.clj

######

all:: \
listlen_dats.clj
regress:: \
listlen_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) listlen_dats.clj

######

all:: \
listmap_dats.clj
regress:: \
listmap_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) listmap_dats.clj

######
#
all:: \
weekday_dats.clj
regress:: \
weekday_dats.clj ; $(CLOJURE2) $<
cleanall:: ; $(RMF) weekday_dats.clj
#
######
#
all:: \
sieve_lazy_dats.clj
test_sieve_lazy:: \
sieve_lazy_dats.clj ; $(CLOJURE2) $<
regress:: test_sieve_lazy
cleanall:: ; $(RMF) sieve_lazy_dats.clj
#
######
#
all:: \
sieve_llazy_dats.clj
test_sieve_llazy:: \
sieve_llazy_dats.clj ; $(CLOJURE2) $<
regress:: test_sieve_llazy
cleanall:: ; $(RMF) sieve_llazy_dats.clj
#
######

%_dats.clj: %.dats ; $(PATSOPT) -d $< | $(ATSCC2CLJ) -o $@

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

###### end of [Makefile] ######
