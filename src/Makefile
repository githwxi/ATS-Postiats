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

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

ATSCCFLAGS=
ATSCCFLAGS=-O2 -g

######

SOURCES := \
  pats_lexing.sats pats_lexing.dats \
  pats_queueref.sats pats_queueref.dats \

SOURCESsta := $(filter %.sats, $(SOURCES))
SOURCESdyn := $(filter %.dats, $(SOURCES))

OBJECTS := $(SOURCES)
OBJECTS := $(patsubst %.sats, %_sats.o, $(OBJECTS))
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

atsopt: \
  pats_main_dats.o \
  $(OBJECTS) \
	$(ATSCC) \
  pats_main_dats.o \
  $(OBJECTS) \

######

%_sats.o: %.sats
	$(ATSCC) $(ATSCCFLAGS) -c $<

%_dats.o: %.dats
	$(ATSCC) $(ATSCCFLAGS) -c $<

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
