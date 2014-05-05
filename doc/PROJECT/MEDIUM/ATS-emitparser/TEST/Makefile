#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

RMF=rm -f

######

all::

######

all:: \
fact_dats.c
fact_dats.c: fact.dats ; $(PATSCC) -ccats -o $@ $<

######

all:: \
fib2_dats.c
fib2_dats.c: fib2.dats ; $(PATSCC) -ccats -o $@ $<

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######