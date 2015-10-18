#
# A simple Makefile
#

######
#
EMCC=emcc
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
#
######

all:: fact2_dats.js

######
#
fact2_dats.c: fact2.dats ; \
$(PATSOPT) --output $@ --dynamic $<
#
fact2_dats.js: fact2_dats.c ; \
$(EMCC) \
  -I${PATSHOME} \
  -I${PATSHOME}/ccomp/runtime \
  --pre-js fact2_pre.js \
  -s EXPORTED_FUNCTIONS="['_ATSJS_fact_']" \
  -o $@ $<
#
######
#
all:: \
fact2_counter_dats.js
#
fact2_counter_dats.c: fact2_counter.dats; $(PATSCC) -ccats $<
fact2_counter_dats.js: fact2_counter_dats.c; $(ATSCC2JS) -o $@ -i $<
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *.map
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) fact2_dats.js
cleanall:: ; $(RMF) fact2_counter_dats.js

###### end of [Makefile] ######
