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
SOURCES_DATS += DATS/atscc2scm_main.dats
SOURCES_DATS += DATS/atscc2scm_emit.dats
SOURCES_DATS += DATS/atscc2scm_emit2.dats

SOURCES_SATS :=
SOURCES_SATS += $(CATSPARSEMIT)/SATS/catsparse.sats

SOURCES_CATS :=
SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_all_dats.c

######
#
all:: ; \
$(MAKE) -C CATS-parsemit all
#
######
#
all:: \
bin_atscc2scm
bin_atscc2scm: \
$(SOURCES_DATS); \
$(PATSCC) \
  -DATS_MEMALLOC_GCBDW -O2 -o bin/atscc2scm \
  $(SOURCES_DATS) $(SOURCES_SATS) $(SOURCES_CATS) -lgc
#
######
#
npm:: bin_atscc2scm
npm:: ; $(CPF) catsparse_sats.c atscc2scm_*_dats.c npm/CATS/.
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
clean:: ; $(RMF) catsparse_sats.c
clean:: ; $(RMF) atscc2scm_*_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./bin/atscc2scm

###### end of [Makefile] ######
