######
#
# Makefile for atsynmark
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

all:: pats2xhtml

######

OBJECTS := \
  pats_utils_sats.o \
  pats_utils_dats.o \
  pats_global_sats.o \
  pats_global_dats.o \
  pats_errmsg_sats.o \
  pats_errmsg_dats.o \
  pats_comarg_sats.o \
  pats_comarg_dats.o \
  pats_symbol_sats.o \
  pats_symbol_dats.o \
  pats_filename_sats.o \
  pats_filename_dats.o \
  pats_intinf_sats.o \
  pats_effect_sats.o \
  pats_effect_dats.o \
  pats_symmap_sats.o \
  pats_symmap_dats.o \
  pats_symenv_sats.o \
  pats_symenv_dats.o \
  pats_staexp1_sats.o \
  pats_staexp1_dats.o \
  pats_staexp1_print_dats.o \
  pats_dynexp1_sats.o \
  pats_dynexp1_dats.o \
  pats_dynexp1_print_dats.o \
  pats_trans1_sats.o \
  pats_trans1_env_sats.o \
  pats_trans1_env_dats.o \
  pats_e1xpval_sats.o \
  pats_e1xpval_dats.o \
  pats_e1xpval_error_dats.o \
  pats_trans1_e0xp_dats.o \
  pats_trans1_error_dats.o \
  pats2xhtml_sats.o \
  pats2xhtml_level1_dats.o \

######

%_sats.o: %_sats.c; \
  $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
%_dats.o: %_dats.c; \
  $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<

######
##
pats2xhtml_sats.o: \
pats2xhtml_sats.c ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $<
##
pats2xhtml_level1_dats.o: \
pats2xhtml_level1_dats.c ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $<
##
######
##
pats2xhtml: \
pats2xhtml_main_dats.c $(OBJECTS) ; \
  $(ATSCC) -O2 $(INCLUDE) $(INCLATS) -o $@ $< $(OBJECTS) -L $(PATSHOME)/utils/libatsynmark -latsynmark -lgmp
##
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) pats_*_?ats.o
clean:: ; $(RMF) pats2xhtml_sats.o
clean:: ; $(RMF) pats2xhtml_*_dats.o

######
##
cleanall:: clean
cleanall:: ; $(RMF) pats2xhtml
##
###### end of [Makefile for atsynmark] ######
