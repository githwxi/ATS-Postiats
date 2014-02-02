#
# A simple Makefile for
# testing the ATS API for gurobi
#

######

ifdef LGUROBI
else
LGUROBI=-lgurobi??
endif

######

include $(PATSHOME)/share/atsmake-pre.mk

######

LDFLAGS += $(LGUROBI)

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test00

######

all:: gurobi_mip1
gurobi_mip1: gurobi_mip1.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) gurobi_mip1

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
