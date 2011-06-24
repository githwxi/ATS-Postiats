#######################################################################
#                                                                     #
#                         Applied Type System                         #
#                                                                     #
#                              Hongwei Xi                             #
#                                                                     #
#######################################################################

#
# ATS/Postiats - Unleashing the Potential of Types!
# Copyright (C) 2011-20?? Hongwei Xi, Boston University
# All rights reserved
#
# ATS is  free software;  you can redistribute it and/or modify it under
# the  terms of the  GNU General Public License as published by the Free
# Software Foundation; either version 2.1, or (at your option) any later
# version.
# 
# ATS is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
# for more details.
# 
# You  should  have  received  a  copy of the GNU General Public License
# along  with  ATS;  see the  file COPYING.  If not, please write to the
# Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#

######
#
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
# Start Time: March, 2011
#
######

$(ATSHOME)=/cs/coursedata/cs525/ATS-0.2.4
ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

ATSGCFLAG=
ATSGCFLAG=-D_ATS_GCATS

ATSCCFLAGS=-g
ATSCCFLAGS=-g -O
ATSCCFLAGS=-g -O2

######

SOURCES := \
  pats_error.sats \
  pats_error.dats \
  pats_counter.sats \
  pats_counter.dats \
  pats_intinf.sats \
  pats_intinf.dats \
  pats_utils.sats \
  pats_utils.dats \
  pats_basics.sats \
  pats_basics.dats \
  pats_stamp.sats \
  pats_stamp.dats \
  pats_symbol.sats \
  pats_symbol.dats \
  pats_filename.sats \
  pats_filename.dats \
  pats_location.sats \
  pats_location.dats \
  pats_errmsg.sats \
  pats_errmsg.dats \
  pats_reader.sats \
  pats_reader.dats \
  pats_lexbuf.sats \
  pats_lexbuf.dats \
  pats_lexing.sats \
  pats_lexing_token.dats \
  pats_lexing_print.dats \
  pats_lexing_error.dats \
  pats_lexing.dats \
  pats_label.sats \
  pats_label.dats \
  pats_effect.sats \
  pats_effect.dats \
  pats_fixity.sats \
  pats_fixity_prec.dats \
  pats_fixity_fxty.dats \
  pats_syntax.sats \
  pats_syntax_print.dats \
  pats_syntax.dats \
  pats_tokbuf.sats \
  pats_tokbuf.dats \
  pats_parsing.sats \
  pats_parsing.dats \
  pats_parsing_error.dats \
  pats_parsing_util.dats \
  pats_parsing_kwds.dats \
  pats_parsing_misc.dats \
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
  pats_dynexp1_syndef.dats \
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
  pats_trans1_dynexp.dats \
  pats_trans1_decl.dats \
  pats_staexp2.sats \
  pats_staexp2.dats \
  pats_staexp2_print.dats \
  pats_staexp2_sort.dats \
  pats_staexp2_scst.dats \
  pats_staexp2_svar.dats \
  pats_staexp2_sVar.dats \
  pats_staexp2_dcon.dats \
  pats_staexp2_util.sats \
  pats_staexp2_util1.dats \
  pats_staexp2_util2.dats \
  pats_dynexp2.sats \
  pats_dynexp2.dats \
  pats_dynexp2_print.dats \
  pats_dynexp2_dcst.dats \
  pats_dynexp2_dvar.dats \
  pats_dynexp2_util.sats \
  pats_dynexp2_util.dats \
  pats_trans2.sats \
  pats_namespace.sats \
  pats_namespace.dats \
  pats_trans2_env.sats \
  pats_trans2_env.dats \
  pats_stacst2.sats \
  pats_stacst2.dats \
  pats_trans2_error.dats \
  pats_trans2_sort.dats \
  pats_trans2_staexp.dats \
  pats_trans2_p1at.dats \
  pats_trans2_dynexp.dats \
  pats_trans2_impdec.dats \
  pats_trans2_decl.dats \
  pats_comarg.sats \
  pats_comarg.dats \

SOURCESsta := $(filter %.sats, $(SOURCES))
SOURCESdyn := $(filter %.dats, $(SOURCES))

OBJECTS := $(SOURCES)
OBJECTS := $(patsubst %.sats, %_sats.o, $(OBJECTS))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

atsopt: \
  pats_main_dats.o $(OBJECTS)
	$(ATSCC) \
  $(ATSGCFLAG) $(ATSCCFLAGS) \
  -o atsopt pats_main_dats.o $(OBJECTS) -lgmp

######

test: \
  test_main_dats.o $(OBJECTS)
	$(ATSCC) \
  $(ATSGCFLAG) $(ATSCCFLAGS) -o test \
  test_main_dats.o $(OBJECTS) \
  && ./test

######

%_sats.o: %.sats
	$(ATSCC) $(ATSCCFLAGS) -c $<

%_dats.o: %.dats
	$(ATSCC) $(ATSCCFLAGS) -c $<

######

#
# HX: '-o .depend' means appending instead of overwriting
#
depend::
	$(RMF) .depend
	$(ATSOPT) -o .depend -dep1 -s $(SOURCESsta) -d $(SOURCESdyn)
	$(ATSOPT) -o .depend -dep1 -d pats_main.dats
include .depend

######

DIR=.
RMF=rm -f
WCL=wc -l

######

srclines:: ; $(WCL) $(SOURCES) pats_main.dats

######

clean:: ; $(RMF) $(DIR)/*~
clean:: ; $(RMF) $(DIR)/*_?ats.o
clean:: ; $(RMF) $(DIR)/*_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) atsopt
cleanall:: ; $(RMF) test

######

###### end of [Makefile] ######
