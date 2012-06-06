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
IATS=-IATS $(PATSHOMEQ) -IATS $(PATSHOMEQ)/src

######

CCFLAGS=-fPIC -O2
INCLUDES=-I$(PATSHOMEQ)/src

######

SOURCES = \
  pats_utils.sats \
  pats_utils.dats \
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
  libatsyntax.sats \
  libatsyntax.dats \

OBJECTS := $(patsubst %.sats, %_sats.o, $(SOURCES))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

ATSLIB=$(ATSHOMEQ)/ccomp/lib
ATSLIB=$(ATSHOMEQ)/ccomp/lib64

######

all:: libatsyntax

######

libatsyntax:: $(OBJECTS)

######

AR=ar

######

pats_utils_sats.o: $(PATSHOME)/src/pats_utils.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_utils_dats.o: $(PATSHOME)/src/pats_utils.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_basics_sats.o: $(PATSHOME)/src/pats_basics.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_basics_dats.o: $(PATSHOME)/src/pats_basics.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_symbol_sats.o: $(PATSHOME)/src/pats_symbol.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_symbol_dats.o: $(PATSHOME)/src/pats_symbol.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_filename_sats.o: $(PATSHOME)/src/pats_filename.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_filename_dats.o: $(PATSHOME)/src/pats_filename.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_location_sats.o: $(PATSHOME)/src/pats_location.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_location_dats.o: $(PATSHOME)/src/pats_location.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_reader_sats.o: $(PATSHOME)/src/pats_reader.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_reader_dats.o: $(PATSHOME)/src/pats_reader.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_lexbuf_sats.o: $(PATSHOME)/src/pats_lexbuf.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_lexbuf_dats.o: $(PATSHOME)/src/pats_lexbuf.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

pats_lexing_sats.o: $(PATSHOME)/src/pats_lexing.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_lexing_dats.o: $(PATSHOME)/src/pats_lexing.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_lexing_token_dats.o: $(PATSHOME)/src/pats_lexing_token.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_lexing_print_dats.o: $(PATSHOME)/src/pats_lexing_print.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
pats_lexing_error_dats.o: $(PATSHOME)/src/pats_lexing_error.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

######

libatsyntax_sats.o: SATS/libatsyntax.sats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@
libatsyntax_dats.o: DATS/libatsyntax.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

######

libatsyntax:: dynloadall_dats.o
dynloadall_dats.o: dynloadall.dats
	$(ATSCC) $(IATS) $(INCLUDES) $(CCFLAGS) -c $<; $(AR) -r libatsyntax.a $@

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) libatsyntax.a

distclean:: cleanall

###### end of [Makefile] ######
