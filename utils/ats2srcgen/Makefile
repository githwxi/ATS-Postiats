######
#
# Makefile for ats2srcgen
#
######

ATSHOMEQ="$(ATSHOME)"
PATSHOMEQ="$(PATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CCFLAGS=-fPIC -O2

######

all:: ats2srcgen

######

OBJECTS := \
  pats_error_sats.o \
  pats_error_dats.o \
  pats_utils_sats.o \
  pats_utils_dats.o \
  pats_global_sats.o \
  pats_global_dats.o \
  pats_comarg_sats.o \
  pats_comarg_dats.o \
  pats_symbol_sats.o \
  pats_symbol_dats.o \
  pats_filename_sats.o \
  pats_filename_dats.o \
  pats_location_sats.o \
  pats_location_dats.o \
  pats_errmsg_sats.o \
  pats_errmsg_dats.o \
  pats_effect_sats.o \
  pats_effect_dats.o \
  pats_symmap_sats.o \
  pats_symmap_dats.o \
  pats_symenv_sats.o \
  pats_symenv_dats.o \
  ats2srcgen_sats.o \
  ats2srcgen_main_dats.o \

######
##
ats2srcgen: $(OBJECTS) ; \
  $(ATSCC) -O2 $(INCLUDE) $(INCLATS) -o $@ $(OBJECTS) -lgmp
cleanall:: ; $(RMF) ats2srcgen
##
######
##
ats2srcgen_sats.o: \
  SATS/ats2srcgen.sats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
ats2srcgen_main_dats.o: \
  DATS/ats2srcgen_main.dats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
######
##
%_sats.o: \
  $(PATSHOME)/src/%.sats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
%_dats.o: \
  $(PATSHOME)/src/%.dats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) */*~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

###### end of [Makefile for ats2srcgen] ######
