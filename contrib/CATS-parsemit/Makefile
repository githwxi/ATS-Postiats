#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: DATS_C

######
#
DATS_C:: CATS/catsparse_all_dats.c
DATS_C:: CATS/catsparse_mylib_dats.c
#
######
#
CATS/catsparse_all_dats.c: \
catsparse_all.dats; $(PATSOPT) -o $@ --dynamic $<
CATS/catsparse_mylib_dats.c: \
catsparse_mylib.dats; $(PATSOPT) -o $@ --dynamic $<
#
######
#
testall:: all
testall:: cleanall
#
######

RMF=rm -f

######

cleanall:: ; $(RMF) ./CATS/catsparse_all_dats.c
cleanall:: ; $(RMF) ./CATS/catsparse_mylib_dats.c

###### end of [Makefile] ######
