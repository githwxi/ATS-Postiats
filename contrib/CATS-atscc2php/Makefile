#
# A simple Makefile
#

######

MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######

CATSPARSEMIT=./CATS-parsemit

######

SOURCES_DATS :=
SOURCES_DATS += DATS/atscc2php_main.dats
SOURCES_DATS += DATS/atscc2php_emit.dats
SOURCES_DATS += DATS/atscc2php_emit2.dats

SOURCES_SATS :=
SOURCES_SATS += $(CATSPARSEMIT)/SATS/catsparse.sats

SOURCES_CATS :=
SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_all_dats.c
SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_mylib_dats.c

######
#
all:: ; \
$(MAKE) -C CATS-parsemit all
#
######
#
all:: \
atscc2php
atscc2php: \
$(SOURCES_DATS); \
$(PATSCC) \
  -DATS_MEMALLOC_GCBDW -O2 -o $@ \
  $(SOURCES_DATS) $(SOURCES_SATS) $(SOURCES_CATS) -lgc
#
######
#
npm:: atscc2php
npm:: ; $(CPF) catsparse_sats.c atscc2php_*_dats.c npm/CATS/.
#
######

CPF=cp -f
RMF=rm -f

######
#
testall:: all
testall:: cleanall
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) ./atscc2php
cleanall:: ; $(RMF) ./npm/CATS/catsparse_sats.c
cleanall:: ; $(RMF) ./npm/CATS/atscc2php_*_dats.c 
#
###### end of [Makefile] ######
