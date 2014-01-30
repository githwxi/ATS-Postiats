#
# A simple Makefile for
# testing the ATS API for gurobi
#

######

include "$(PATSHOME)/share/atsmake-pre.mk"

######

LDFLAGS += -lgurobi

######

MYCCRULE=MYCCRULE

######

MALLOCFLAG=-DATS_MEMALLOC_LIBC

######

all:: test00
test00: test00.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test00

######

include "$(PATSHOME)/share/atsmake-post.mk"

######

###### end of [Makefile] ######
