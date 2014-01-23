#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
SOURCES_SATS += falcon.sats
#
SOURCES_DATS += falcon_main.dats
SOURCES_DATS += falcon_symbol.dats
SOURCES_DATS += falcon_position.dats
SOURCES_DATS += falcon_tokener.dats
SOURCES_DATS += falcon_genes.dats
SOURCES_DATS += falcon_parser.dats
SOURCES_DATS += falcon_mylib.dats
#
MYTARGET=falcon
MYPORTDIR=MYPORTDIR
#
include $(PATSHOME)/share/atsmake-post.mk
#
PATS2XHTML=$(PATSHOME)/bin/pats2xhtml
%_dats.html: %.dats ; $(PATS2XHTML) -o $@ -d $<
#
cleanall:: ; $(RMF) *_?ats.c
#
cleanall:: ; $(RMF) falcon
#
###### end of [Makefile] ######
