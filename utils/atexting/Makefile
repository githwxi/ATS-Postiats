#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: DATS_C

######

DATS_C:: \
atexting_mylib.dats; \
$(PATSOPT) -o ./CATS/atexting_mylib_dats.c --dynamic $<
DATS_C:: \
atexting_include_all.dats; \
$(PATSOPT) -o ./CATS/atexting_include_all_dats.c --dynamic $<

######
#
testall:: all
testall:: cleanall
#
######

RMF=rm -f

######

cleanall:: ; $(RMF) ./CATS/atexting_mylib_dats.c
cleanall:: ; $(RMF) ./CATS/atexting_include_all_dats.c

###### end of [Makefile] ######
