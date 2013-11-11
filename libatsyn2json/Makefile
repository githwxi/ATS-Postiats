# (***********************************************************************)
# (*                                                                     *)
# (*                         Applied Type System                         *)
# (*                                                                     *)
# (***********************************************************************)

# (*
# ** ATS/Postiats - Unleashing the Potential of Types!
# ** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
# ** All rights reserved
# **
# ** ATS is free software;  you can  redistribute it and/or modify it under
# ** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
# ** Free Software Foundation; either version 3, or (at  your  option)  any
# ** later version.
# ** 
# ** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
# ** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
# ** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
# ** for more details.
# ** 
# ** You  should  have  received  a  copy of the GNU General Public License
# ** along  with  ATS;  see the  file COPYING.  If not, please write to the
# ** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
# ** 02110-1301, USA.
# *)

# (* ****** ****** *)
# //
# // Author: Hongwei Xi
# // Authoremail: gmhwxi AT gmail DOT com
# // Start Time: November, 2013
# //
# (* ****** ****** *)

######

ATSHOMEQ="$(ATSHOME)"
PATSHOMEQ="$(PATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSCCFLAGS=
ATSRUNTIME=$(ATSHOMEQ)/ccomp/runtime

######

ATSLIB=$(ATSHOMEQ)/ccomp/lib
ATSLIB64=$(ATSHOMEQ)/ccomp/lib64

######

CCFLAGS=-fPIC -O2

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

all:: libatsyn2json

######

SOURCES = \
  pats_error.sats \
  pats_error.dats \
  pats_utils.sats \
  pats_utils.dats \
  pats_global.sats \
  pats_global.dats \
  pats_basics.sats \
  pats_basics.dats \
  pats_symbol.sats \
  pats_symbol.dats \
  pats_filename.sats \
  pats_filename.dats \
  pats_location.sats \
  pats_location.dats \
  pats_reader.sats \
  pats_reader.dats \
  pats_lexbuf.sats \
  pats_lexbuf.dats \
  pats_lexing.sats \
  pats_lexing.dats \
  pats_lexing_token.dats \
  pats_lexing_print.dats \
  pats_lexing_error.dats \
  pats_label.sats \
  pats_label.dats \
  pats_fixity.sats \
  pats_fixity_prec.dats \
  pats_fixity_fxty.dats \
  pats_syntax.sats \
  pats_syntax.dats \
  pats_syntax_print.dats \
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
  pats_symmap.sats \
  pats_symmap.dats \
  pats_symenv.sats \
  pats_symenv.dats \
  pats_staexp1.sats \
  pats_staexp1.dats \
  pats_staexp1_print.dats \
  pats_dynexp1.sats \
  pats_dynexp1.dats \
  pats_dynexp1_print.dats \
  pats_trans1.sats \
  pats_trans1_env.sats \
  pats_trans1_env.dats \
  pats_e1xpval.sats \
  pats_e1xpval.dats \
  pats_e1xpval_error.dats \
  pats_trans1_error.dats \
  pats_trans1_e0xp.dats \
  pats_trans1_effect.dats \
  pats_trans1_sort.dats \
  pats_trans1_staexp.dats \
  pats_trans1_p0at.dats \
  pats_trans1_syndef.dats \
  pats_trans1_dynexp.dats \
  pats_trans1_decl.dats \
  pats_staexp2.sats \
  pats_staexp2.dats \
  pats_stacst2.sats \
  pats_stacst2.dats \
  pats_staexp2_print.dats \
  pats_staexp2_pprint.dats \
  pats_staexp2_sort.dats \
  pats_staexp2_scst.dats \
  pats_staexp2_svar.dats \
  pats_staexp2_svvar.dats \
  pats_staexp2_hole.dats \
  pats_staexp2_ctxt.dats \
  pats_staexp2_dcon.dats \
  pats_staexp2_skexp.dats \
  pats_staexp2_szexp.dats \
  pats_staexp2_util.sats \
  pats_staexp2_util1.dats \
  pats_staexp2_util2.dats \
  pats_staexp2_util3.dats \
  pats_staexp2_error.sats \
  pats_staexp2_error.dats \
  pats_staexp2_solve.sats \
  pats_staexp2_solve.dats \
  pats_patcst2.sats \
  pats_patcst2.dats \
  pats_dynexp2.sats \
  pats_dynexp2.dats \
  pats_dyncst2.sats \
  pats_dyncst2.dats \
  pats_dynexp2_print.dats \
  pats_dynexp2_dcst.dats \
  pats_dynexp2_dvar.dats \
  pats_dynexp2_dmac.dats \
  pats_dynexp2_util.sats \
  pats_dynexp2_util.dats \
  pats_trans2.sats \
  pats_namespace.sats \
  pats_namespace.dats \
  pats_trans2_env.sats \
  pats_trans2_env.dats \
  pats_trans2_error.dats \
  pats_trans2_sort.dats \
  pats_trans2_staexp.dats \
  pats_trans2_p1at.dats \
  pats_trans2_dynexp.dats \
  pats_trans2_impdec.dats \
  pats_trans2_decl.dats \

######

OBJECTS := $(patsubst %.sats, %_sats.o, $(SOURCES))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

libatsyn2json:: $(OBJECTS)

######

%_sats.o: $(PATSHOME)/src/%.sats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsyn2json.a $@
%_dats.o: $(PATSHOME)/src/%.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsyn2json.a $@

######

libatsyn2json:: libatsyn2json_p2at_dats.o
libatsyn2json_p2at_dats.o: DATS/libatsyn2json_p2at.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsyn2json.a $@

libatsyn2json:: libatsyn2json_d2exp_dats.o
libatsyn2json_d2exp_dats.o: DATS/libatsyn2json_d2exp.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsyn2json.a $@

######

AR=ar
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) libatsyn2json.a

distclean:: cleanall

###### end of [Makefile] ######
