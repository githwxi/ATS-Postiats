#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
LDFLAGS += -lgc
MALLOCFLAG = -DATS_MEMALLOC_GCBDW
#
SOURCES_SATS += falcon.sats
#
ifeq ($(strip $(MAKECMDGOALS)),falcon)
  MYTARGET=$(MAKECMDGOALS)
  SOURCES_DATS += falcon_main.dats
else ifeq ($(strip $(MAKECMDGOALS)),cnf_timeout)
  MYTARGET=$(MAKECMDGOALS)
  SOURCES_DATS += cnf_timeout.dats
else
  SOURCES_DATS += falcon_main.dats
endif
SOURCES_DATS += falcon_symbol.dats
SOURCES_DATS += falcon_position.dats
SOURCES_DATS += falcon_tokener.dats
SOURCES_DATS += falcon_genes.dats
SOURCES_DATS += falcon_parser.dats
SOURCES_DATS += falcon_cnfize.dats
SOURCES_DATS += falcon_gmeanvar.dats
SOURCES_DATS += falcon_algorithm1.dats
SOURCES_DATS += falcon_mylib.dats
#
MYPORTDIR=MYPORTDIR
#
include $(PATSHOME)/share/atsmake-post.mk
#
PATS2XHTML=$(PATSHOME)/bin/pats2xhtml
%_dats.html: %.dats ; $(PATS2XHTML) -o $@ -d $<
#
cleanall:: ; $(RMF) *_?ats.c
#
cleanall:: ; $(RMF) falcon cnf_timeout
cleanall:: ; $(RMF) MYPORTDIR/*
#
###### end of [Makefile] ######
