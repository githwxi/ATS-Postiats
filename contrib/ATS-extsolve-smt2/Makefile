##
## ATS-extsolve-smt2:
## Solving ATS-constraints with SMT2
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
CFLAGS2 +=-DATS_MEMALLOC_LIBC
CFLAGS2 += \
$(shell pkg-config --cflags json-c)
CFLAGS2 += \
-I${PATSHOMEQ}/atscntrb/atscntrb-libjson-c
#
######

EXTRA_CFLAGS :=

######

PATSCC2=$(PATSCC) $(CFLAGS2) $(EXTRA_CFLAGS)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs json-c)
LDFLAGS +=-lgc

######

INCLUDE :=
INCLUDE += -I$(PATSHOMEQ)
INCLUDE += -I$(PATSHOMEQ)/ccomp/runtime

######

PATSOLVE=./ATS-extsolve

######

SOURCES_SATS= \
$(PATSOLVE)/SATS/patsolve_cnstrnt.sats \
$(PATSOLVE)/SATS/patsolve_parsing.sats \

######

SOURCES_CATS= \
$(PATSOLVE)/CATS/patsolve_cnstrnt_dats.c \
$(PATSOLVE)/CATS/patsolve_parsing_dats.c \

######

SOURCES_DATS :=
SOURCES_DATS += patsolve_smt2_main.dats
SOURCES_DATS += patsolve_smt2_mylib.dats
SOURCES_DATS += patsolve_smt2_commarg.dats
SOURCES_DATS += patsolve_smt2_solving.dats

######

TARGETS_DATS_O = \
$(patsubst %.dats, %_dats.o, $(SOURCES_DATS))

######
#
all:: ; \
$(MAKE) -C ATS-extsolve DATS_C
#
all:: \
patsolve_smt2
patsolve_smt2: \
$(TARGETS_DATS_O); \
$(PATSCC2) -O2 -o $@ \
$(SOURCES_SATS) $(SOURCES_CATS) $(TARGETS_DATS_O) $(LDFLAGS)
#
cleanall:: ; $(RMF) patsolve_smt2
#
######
#
npm:: all
npm:: ; $(CPF) patsolve_smt2_*_dats.c npm/CATS/.
npm:: ; $(CPF) patsolve_parsing_sats.c npm/CATS/.
npm:: ; $(CPF) patsolve_cnstrnt_sats.c npm/CATS/.
#
######

%_dats.o: DATS/%.dats; $(PATSCC2) -c $<

######

testall:: all
testall:: cleanall

######

CPF=cp -f
RMF=rm -f
MAKE=make

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./npm/CATS/patsolve_smt2_*_dats.c
cleanall:: ; $(RMF) ./npm/CATS/patsolve_parsing_sats.c
cleanall:: ; $(RMF) ./npm/CATS/patsolve_cnstrnt_sats.c

######

## end of [Makefile] ##
