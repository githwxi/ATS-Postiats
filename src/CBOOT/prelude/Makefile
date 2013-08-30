#
# The main Makefile for CBOOT/prelude
#

######

CCOMP=gcc

######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

all:: allsrc

######

SOURCES := \
  basics_sta_sats.c \
  basics_dyn_sats.c \
  ats_main_prelude_dats.c \
  DATS_basics_dats.c \
  DATS_bool_dats.c \
  DATS_char_dats.c \
  DATS_float_dats.c \
  DATS_integer_dats.c \
  DATS_sizetype_dats.c \
  DATS_pointer_dats.c \
  DATS_reference_dats.c \
  DATS_string_dats.c \
  DATS_lazy_dats.c \
  DATS_lazy_vt_dats.c \
  DATS_printf_dats.c \
  DATS_filebas_dats.c \
  DATS_list_dats.c \
  DATS_list_vt_dats.c \
  DATS_list0_dats.c \
  DATS_option_dats.c \
  DATS_option_vt_dats.c \
  DATS_option0_dats.c \
  DATS_array_dats.c \
  DATS_array0_dats.c \
  DATS_matrix_dats.c \
  DATS_matrix0_dats.c \
  DATS_ptrarr_dats.c \
  DATS_unsafe_dats.c \

######

allsrc:: $(SOURCES)

######

basics_sta_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/prelude/basics_sta.sats
basics_dyn_sats.c: ; \
  $(ATSOPT) -o $@ --static $(ATSHOME)/prelude/basics_dyn.sats
ats_main_prelude_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/ats_main_prelude.dats
DATS_basics_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/basics.dats
DATS_bool_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/bool.dats
DATS_char_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/char.dats
DATS_float_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/float.dats
DATS_integer_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/integer.dats
DATS_sizetype_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/sizetype.dats
DATS_pointer_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/pointer.dats
DATS_reference_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/reference.dats
DATS_string_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/string.dats
DATS_lazy_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/lazy.dats
DATS_lazy_vt_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/lazy_vt.dats
DATS_printf_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/printf.dats
DATS_filebas_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/filebas.dats
DATS_list_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/list.dats
DATS_list_vt_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/list_vt.dats
DATS_list0_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/list0.dats
DATS_option_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/option.dats
DATS_option_vt_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/option_vt.dats
DATS_option0_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/option0.dats
DATS_array_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/array.dats
DATS_array0_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/array0.dats
DATS_matrix_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/matrix.dats
DATS_matrix0_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/matrix0.dats
DATS_ptrarr_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/ptrarr.dats
DATS_unsafe_dats.c: ; \
  $(ATSOPT) -o $@ --dynamic $(ATSHOME)/prelude/DATS/unsafe.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######


