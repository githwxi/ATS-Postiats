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

CBOOT:: ; $(CPF) catsparse_sats.c CBOOT/.
CBOOT:: ; $(CPF) atscc2erl_*_dats.c CBOOT/.
CBOOT:: ; $(CPF) libatscc2erl_*_dats.c CBOOT/.

######

CATSPARSEMIT=./CATS-parsemit

######

SOURCES_DATS :=
SOURCES_DATS += DATS/atscc2erl_main.dats
SOURCES_DATS += DATS/atscc2erl_emit.dats
SOURCES_DATS += DATS/atscc2erl_emit2.dats

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
atscc2erl
atscc2erl: \
$(SOURCES_DATS); \
$(PATSCC) -DATS_MEMALLOC_GCBDW \
  -O2 -o $@ $(SOURCES_DATS) $(SOURCES_SATS) $(SOURCES_CATS) -lgc
#
######
#
npm:: atscc2erl
npm:: ; $(CPF) catsparse_sats.c atscc2erl_*_dats.c npm/CATS/.
#
######
#
OBJECTS := \
  catsparse_sats.o \
  catsparse_all_dats.o \
  atscc2erl_main_dats.o \
  atscc2erl_emit_dats.o \
  atscc2erl_emit2_dats.o \
  libatscc2erl_ext_dats.o \
#
libatscc2erl.a: $(OBJECTS); $(AR) -r $@ $(OBJECTS)
#
######
#
catsparse_sats.o: \
$(CATSPARSEMIT)/SATS/catsparse.sats; $(PATSCC) -O2 -c $<
#
catsparse_all_dats.o: \
$(CATSPARSEMIT)/CATS/catsparse_all_dats.c; $(PATSCC) -O2 -c $<
#
%_dats.o: DATS/%.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS ATSCC2ERL_MAIN_NONE -O2 -c $<
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
clean:: ; $(RMF) atscc2erl_*_?ats.c
clean:: ; $(RMF) libatscc2erl_ext_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./atscc2erl
cleanall:: ; $(RMF) ./libatscc2erl.a

###### end of [Makefile] ######
