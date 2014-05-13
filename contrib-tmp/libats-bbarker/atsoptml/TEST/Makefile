#
# A simple Makefile for
# testing the ATS API for gurobi
#

######

ifdef LGUROBI
else
LGUROBI=-lgurobi??
endif

#
# GUROBI_HOME should already be set for most 
# typical Gurobi installations.
#
ifdef GUROBI_HOME
else
GUROBI_HOME=??
endif

######

include $(PATSHOME)/share/atsmake-pre.mk

######

LDFLAGS += $(LGUROBI) -L$(GUROBI_HOME)/lib

######

CFLAGS += -I$(GUROBI_HOME)/include

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) $(CFLAGS) -o $@ $< $(LDFLAGS) 
cleanall:: ; $(RMF) test00

######

all:: gurobi_mip1
gurobi_mip1: gurobi_mip1.dats ; $(PATSCC2) $(CFLAGS) -o $@ $< $(LDFLAGS) $(MALLOCFLAG)
cleanall:: ; $(RMF) gurobi_mip1 mip1.log mip1.lp

######

all:: gurobi_tsp
gurobi_tsp: gurobi_tsp.dats ; $(PATSCC2) $(CFLAGS) -o $@ $< $(LDFLAGS) $(MALLOCFLAG)
cleanall:: ; $(RMF) gurobi_tsp tsp.log

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
