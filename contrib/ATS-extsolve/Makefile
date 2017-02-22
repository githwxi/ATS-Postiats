##
## ATS-extsolve:
## For solving ATS-constraints
## with external SMT-solvers
##

######
##
## Author: Hongwei Xi
## Authoremail: gmhwxiATgmailDOTcom
##
## Start time: May, 2015
##
######

CC=gcc

######

ifdef \
PATSHOME
PATSHOMEQ="$(PATSHOME)"
else
ifdef ATSHOME
  PATSHOMEQ="$(ATSHOME)"
else
  PATSHOMEQ="/usr/local/lib/ats2-postiats"
endif
endif

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::

######
#
CFLAGS :=
CFLAGS += -DATS_MEMALLOC_LIBC
#
CFLAGS2 :=
#
CFLAGS2 += \
-I${PATSHOMEQ}/contrib
CFLAGS2 += \
$(shell pkg-config --cflags json-c)
#
######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs json-c)

######

EXTRAFLAGS :=

######
#
INCLUDE :=
INCLUDE += -I$(PATSHOMEQ)
INCLUDE += -I$(PATSHOMEQ)/ccomp/runtime
#
######

SOURCES_SATS= \
  patsolve_cnstrnt.sats \
  patsolve_parsing.sats \

######

SOURCES_DATS= \
  patsolve_main.dats \
  patsolve_mylib.dats \
  patsolve_commarg.dats \
  patsolve_cnstrnt.dats \
  patsolve_parsing.dats \

######

OBJECTS_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))

OBJECTS_DATS_O := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

######

OBJECTS :=
OBJECTS += $(OBJECTS_SATS_O)
OBJECTS += $(OBJECTS_DATS_O)

######

PATSCC2 = $(PATSCC) $(CFLAGS)
PATSCC3 = $(PATSCC) $(CFLAGS) $(CFLAGS2)

######
#
all:: patsolve
#
patsolve: \
$(OBJECTS) ; \
$(PATSCC) $(INCLUDE) -o $@ $^ $(LDFLAGS) $(EXTRAFLAGS)
#
cleanall:: ; $(RMF) patsolve
#
######

patsolve_main_dats.o: \
DATS/patsolve_main.dats; $(PATSCC2) -c $<

######

patsolve_mylib_dats.o: \
DATS/patsolve_mylib.dats; $(PATSCC3) -c $<

######

patsolve_commarg_sats.o: \
SATS/patsolve_commarg.sats; $(PATSCC) -c $<
patsolve_commarg_dats.o: \
DATS/patsolve_commarg.dats; $(PATSCC3) -c $<

######

patsolve_cnstrnt_sats.o: \
SATS/patsolve_cnstrnt.sats; $(PATSCC) -c $<
patsolve_cnstrnt_dats.o: \
DATS/patsolve_cnstrnt.dats; $(PATSCC2) -c $<

######

patsolve_parsing_sats.o: \
SATS/patsolve_parsing.sats; $(PATSCC3) -c $<
patsolve_parsing_dats.o: \
DATS/patsolve_parsing.dats; $(PATSCC3) -c $<

######
#
DATS_C:: \
DATS/patsolve_cnstrnt.dats; \
$(PATSOPT) -o CATS/patsolve_cnstrnt_dats.c --dynamic $<
DATS_C:: \
DATS/patsolve_parsing.dats; \
$(PATSOPT) -o CATS/patsolve_parsing_dats.c --dynamic $<
#
# cleanall:: ; $(RMF) CATS/patsolve_*_dats.c
#
######
#
-include .depend
#
depend:: ; $(RMF) .depend
#
ifeq ("$(strip $(SOURCES_SATS))","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCES_SATS)
endif
ifeq ("$(strip $(SOURCES_DATS))","")
else
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCES_DATS)
endif
#
######

testall:: all
testall:: DATS_C
testall:: cleanall

######

RMF=rm -f

######

cleanats:: ; $(RMF) *~
cleanats:: ; $(RMF) SATS/*~
cleanats:: ; $(RMF) DATS/*~
cleanats:: ; $(RMF) DATS/CNSTRNT/*~
cleanats:: ; $(RMF) DATS/PARSING/*~
cleanats:: ; $(RMF) *_?ats.o
cleanats:: ; $(RMF) *_?ats.c

######

clean: cleanats

######

cleanall:: cleanats
cleanall:: ; $(RMF) .depend

######

## end of [Makefile] ##
