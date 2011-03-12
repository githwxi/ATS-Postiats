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
  pats_utils.sats \
  pats_utils.dats \
  pats_filename.sats \
  pats_filename.dats \
  pats_location.sats \
  pats_location.dats \
  pats_lexbuf.sats \
  pats_lexbuf.dats \
  pats_lexing.sats \
  pats_lexing_token.dats \
  pats_lexing_print.dats \
  pats_lexing.dats \

SOURCESsta := $(filter %.sats, $(SOURCES))
SOURCESdyn := $(filter %.dats, $(SOURCES))

OBJECTS := $(SOURCES)
OBJECTS := $(patsubst %.sats, %_sats.o, $(OBJECTS))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

atsopt: \
  pats_main_dats.o $(OBJECTS)
	$(ATSCC) \
  $(ATSGCFLAG) $(ATSCCFLAGS) -o atsopt \
  pats_main_dats.o $(OBJECTS)

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

######

clean:: ; $(RMF) $(DIR)/*~
clean:: ; $(RMF) $(DIR)/*_?ats.o
clean:: ; $(RMF) $(DIR)/*_?ats.c

cleanall:: clean

######

###### end of [Makefile] ######
