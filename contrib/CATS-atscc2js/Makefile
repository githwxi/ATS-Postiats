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
CBOOT:: ; $(CPF) atscc2js_*_dats.c CBOOT/.
CBOOT:: ; $(CPF) libatscc2js_*_dats.c CBOOT/.

######

CATSPARSEMIT=./CATS-parsemit

######

SOURCES_DATS :=
SOURCES_DATS += atscc2js_main.dats
SOURCES_DATS += atscc2js_emit.dats
SOURCES_DATS += atscc2js_emit2.dats

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
atscc2js
atscc2js: \
$(SOURCES_DATS); \
$(PATSCC) -DATS_MEMALLOC_GCBDW \
  -O2 -o $@ $(SOURCES_DATS) $(SOURCES_SATS) $(SOURCES_CATS) -lgc
#
######
#
OBJECTS := \
  catsparse_sats.o \
  catsparse_all_dats.o \
  catsparse_mylib_dats.o \
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
catsparse_mylib_dats.o: \
$(CATSPARSEMIT)/CATS/catsparse_mylib_dats.c; $(PATSCC) -O2 -c $<
#
######
#
%_dats.o: %.dats; \
$(PATSCC) -D_GNU_SOURCE -DATS ATSCC2JS_MAIN_NONE -O2 -c $<
#
######

CPF=cp -f
RMF=rm -f

######
#
CATSPARSEMIT_source=\
$(PATSHOMERELOC)/projects/MEDIUM/CATS-parsemit
#
pkgreloc:: ; \
$(CPF) $(CATSPARSEMIT_source)/SATS/catsparse.sats $(CATSPARSEMIT)/.
pkgreloc:: ; \
$(CPF) $(CATSPARSEMIT_source)/SATS/catsparse_*.sats $(CATSPARSEMIT)/.
pkgreloc:: ; \
$(CPF) $(CATSPARSEMIT_source)/CATS/catsparse_*_dats.c $(CATSPARSEMIT)/.
#
######
#
build:: pkgreloc
build:: atscc2js
#
testall:: build
testall:: cleanall
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) catsparse_sats.c
clean:: ; $(RMF) atscc2js_*_?ats.c
clean:: ; $(RMF) libatscc2js_ext_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./atscc2js
cleanall:: ; $(RMF) ./libatscc2js.a
cleanall:: ; $(RMF) ./.CATS-parsemit/*

###### end of [Makefile] ######
