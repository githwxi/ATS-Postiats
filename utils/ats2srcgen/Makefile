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

SOURCES := \
  pats_error.sats \
  pats_error.dats \
  pats_utils.sats \
  pats_utils.dats \
  pats_global.sats \
  pats_global.dats \
  pats_basics.sats \
  pats_basics.dats \
  pats_errmsg.sats \
  pats_errmsg.dats \
  pats_comarg.sats \
  pats_comarg.dats \
  pats_symbol.sats \
  pats_symbol.dats \
  pats_filename.sats \
  pats_filename.dats \
  pats_filename_reloc.dats \
  pats_location.sats \
  pats_location.dats \
  pats_label.sats \
  pats_label.dats \
  pats_fixity.sats \
  pats_fixity_prec.dats \
  pats_fixity_fxty.dats \
  pats_intinf.sats \
  pats_effect.sats \
  pats_effect.dats \
  pats_symmap.sats \
  pats_symmap.dats \
  pats_symenv.sats \
  pats_symenv.dats \
  pats_syntax.sats \
  pats_syntax.dats \
  pats_syntax_print.dats \
  pats_reader.sats \
  pats_reader.dats \
  pats_lexbuf.sats \
  pats_lexbuf.dats \
  pats_lexing.sats \
  pats_lexing.dats \
  pats_lexing_token.dats \
  pats_lexing_print.dats \
  pats_lexing_error.dats \
  pats_tokbuf.sats \
  pats_tokbuf.dats \
  pats_parsing.sats \
  pats_parsing.dats \
  pats_parsing_error.dats \
  pats_parsing_util.dats \
  pats_parsing_kwds.dats \
  pats_parsing_base.dats \
  pats_parsing_e0xp.dats \
  pats_parsing_sort.dats \
  pats_parsing_staexp.dats \
  pats_parsing_p0at.dats \
  pats_parsing_dynexp.dats \
  pats_parsing_decl.dats \
  pats_parsing_toplevel.dats \
  pats_staexp1.sats \
  pats_staexp1.dats \
  pats_staexp1_print.dats \
  pats_dynexp1.sats \
  pats_dynexp1.dats \
  pats_dynexp1_print.dats \
  pats_trans1.sats \
  pats_e1xpval.sats \
  pats_e1xpval.dats \
  pats_e1xpval_error.dats \
  pats_trans1_env.sats \
  pats_trans1_env.dats \
  pats_trans1_e0xp.dats \
  pats_trans1_error.dats \
  pats_trans1_effect.dats \
  pats_trans1_sort.dats \
  pats_trans1_staexp.dats \
  pats_trans1_p0at.dats \
  pats_trans1_syndef.dats \
  pats_trans1_dynexp.dats \
  pats_trans1_decl.dats \

######

OBJECTS := $(patsubst %.sats, %_sats.o, $(SOURCES))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######
##
OBJECTS := \
  $(OBJECTS) \
  ats2srcgen_sats.o \
  ats2srcgen_main_dats.o \
##
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
