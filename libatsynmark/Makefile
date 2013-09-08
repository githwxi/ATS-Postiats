#########################################################################
#                                                                       #
#                         Applied Type System                           #
#                                                                       #
#                              Hongwei Xi                               #
#                                                                       #
#########################################################################

#
#  ATS - Unleashing the Power of Types!
#
#  Copyright (C) 2002-2007 Hongwei Xi.
#
#  ATS is free software;  you can  redistribute it and/or modify it under
#  the terms of the GNU LESSER GENERAL PUBLIC LICENSE as published by the
#  Free Software Foundation; either version 2.1, or (at your option)  any
#  later version.
# 
#  ATS is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
#  for more details.
# 
#  You  should  have  received  a  copy of the GNU General Public License
#  along  with  ATS;  see  the  file  COPYING.  If not, write to the Free
#  Software Foundation, 51  Franklin  Street,  Fifth  Floor,  Boston,  MA
#  02110-1301, USA.
#

######

#
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSCCFLAGS=
ATSRUNTIME=$(ATSHOMEQ)/ccomp/runtime
PATSHOMEQ="$(PATSHOME)"

######

CCFLAGS=-fPIC -O2

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

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
  pats_syntax.sats \
  pats_syntax.dats \
  pats_syntax_print.dats \

######

OBJECTS := $(patsubst %.sats, %_sats.o, $(SOURCES))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

ATSLIB=$(ATSHOMEQ)/ccomp/lib
ATSLIB=$(ATSHOMEQ)/ccomp/lib64

######

all:: libatsynmark

######

libatsynmark:: $(OBJECTS)

######

AR=ar

######

%_sats.o: $(PATSHOME)/src/%.sats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@
%_dats.o: $(PATSHOME)/src/%.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@

######

libatsynmark:: libatsynmark_sats.o
libatsynmark_sats.o: SATS/libatsynmark.sats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@

libatsynmark:: libatsynmark_dats.o
libatsynmark_dats.o: DATS/libatsynmark.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@

libatsynmark:: libatsynmark_psynmark_dats.o
libatsynmark:: libatsynmark_pats2xhtml_dats.o
libatsynmark:: libatsynmark_pats2xhtml_bground_dats.o
libatsynmark:: libatsynmark_pats2xhtml_embedded_dats.o
libatsynmark_psynmark_dats.o: DATS/libatsynmark_psynmark.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@
libatsynmark_pats2xhtml_dats.o: DATS/libatsynmark_pats2xhtml.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@
libatsynmark_pats2xhtml_bground_dats.o: DATS/libatsynmark_pats2xhtml_bground.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@
libatsynmark_pats2xhtml_embedded_dats.o: DATS/libatsynmark_pats2xhtml_embedded.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@

######

libatsynmark:: dynloadall_dats.o
dynloadall_dats.o: dynloadall.dats
	$(ATSCC) $(INCLATS) $(INCLUDE) $(CCFLAGS) -c $<; $(AR) -r libatsynmark.a $@

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) libatsynmark.a

distclean:: cleanall

###### end of [Makefile] ######
