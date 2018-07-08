#
# A simple Makefile
#

######

AR=ar
CPF=cp -f
RMF=rm -f
MAKE=make

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######

CBOOT:: ; $(CPF) catsparse_sats.c CBOOT/.
CBOOT:: ; $(CPF) atscc2js_*_dats.c CBOOT/.
CBOOT:: ; $(CPF) libatscc2js_*_dats.c CBOOT/.

######

CATSPARSEMIT=./CATS-parsemit

######
#
SOURCES_DATS :=
SOURCES_DATS += DATS/atscc2js_main.dats
SOURCES_DATS += DATS/atscc2js_emit.dats
SOURCES_DATS += DATS/atscc2js_emit2.dats
#
SOURCES_SATS :=
SOURCES_SATS += $(CATSPARSEMIT)/SATS/catsparse.sats
#
SOURCES_CATS :=
SOURCES_CATS += $(CATSPARSEMIT)/CATS/catsparse_all_dats.c
#
######
#
all:: ; \
$(MAKE) -C CATS-parsemit all
#
######
#
all:: \
bin_atscc2js
bin_atscc2js: \
$(SOURCES_DATS); \
$(PATSCC) \
  -O2 -DATS_MEMALLOC_GCBDW -o bin/atscc2js \
  $(SOURCES_DATS) $(SOURCES_SATS) $(SOURCES_CATS) -lgc
#
######
#
npm:: bin_atscc2js
npm:: ; $(CPF) catsparse_sats.c atscc2js_*_dats.c npm/CATS/.
#
######
#
OBJECTS := \
  catsparse_sats.o \
  catsparse_all_dats.o \
  atscc2js_main_dats.o \
  atscc2js_emit_dats.o \
  atscc2js_emit2_dats.o \
  libatscc2js_ext_dats.o \
#
libatscc2js.a: $(OBJECTS); $(AR) -r $@ $(OBJECTS)
#
######
#
catsparse_sats.o: \
$(CATSPARSEMIT)/SATS/catsparse.sats; $(PATSCC) -O2 -c $<
#
catsparse_all_dats.o: \
$(CATSPARSEMIT)/CATS/catsparse_all_dats.c; $(PATSCC) -O2 -c $<
#
######
#
%_dats.o: DATS/%.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS ATSCC2JS_MAIN_NONE -O2 -c $<
#
######
#
testall:: all
testall:: cleanall
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) catsparse_sats.c
clean:: ; $(RMF) atscc2js_*_?ats.c
clean:: ; $(RMF) libatscc2js_ext_?ats.c

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) ./bin/atscc2js
cleanall:: ; $(RMF) ./libatscc2js.a
cleanall:: ; $(RMF) ./npm/CATS/catsparse_sats.c
cleanall:: ; $(RMF) ./npm/CATS/atscc2js_*_dats.c 
#
###### end of [Makefile] ######
