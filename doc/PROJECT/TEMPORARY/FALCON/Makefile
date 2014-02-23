#
# A simple Makefile
#
include $(PATSHOME)/share/atsmake-pre.mk
#
CFLAGS += -O2
#
LDFLAGS += -lgc -lm
MALLOCFLAG = -DATS_MEMALLOC_GCBDW
#
SOURCES_SATS += falcon.sats
#
SOURCES_DATS += falcon_symbol.dats
SOURCES_DATS += falcon_position.dats
SOURCES_DATS += falcon_tokener.dats
SOURCES_DATS += falcon_genes.dats
SOURCES_DATS += falcon_parser.dats
SOURCES_DATS += falcon_cnfize.dats
SOURCES_DATS += falcon_cnfize_ifnot.dats
SOURCES_DATS += falcon_expvar.dats
SOURCES_DATS += falcon_gmeanvar.dats
SOURCES_DATS += falcon_algorithm1.dats
SOURCES_DATS += falcon_mylib.dats
#
SOURCES_DATS_main += $(SOURCES_DATS)
SOURCES_DATS_main += falcon_main.dats
#
SOURCES_DATS_cmdline += $(SOURCES_DATS)
SOURCES_DATS_cmdline += falcon_cmdline.dats
#
include $(PATSHOME)/share/atsmake-post.mk
#
SOURCES_SATS_O := \
  $(patsubst %.sats, %_sats.o, $(SOURCES_SATS))
SOURCES_DATS_O_main := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS_main))
SOURCES_DATS_O_cmdline := \
  $(patsubst %.dats, %_dats.o, $(SOURCES_DATS_cmdline))
#
all:: falcon_main
falcon_main: \
  $(SOURCES_SATS_O) \
  $(SOURCES_DATS_O_main) ; \
  $(PATSCC) $(INCLUDE) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) falcon_main
#
all:: falcon_cmdline
falcon_cmdline: \
  $(SOURCES_SATS_O) \
  $(SOURCES_DATS_O_cmdline) ; \
  $(PATSCC) $(INCLUDE) $(CFLAGS) -o $@ $^ $(LDFLAGS)
cleanall:: ; $(RMF) falcon_cmdline
#
depend:: ; $(PATSOPT) --output-a .depend --depgen -d falcon_main.dats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d falcon_cmdline.dats
#
PATS2XHTML=$(PATSHOME)/bin/pats2xhtml
%_sats.html: %.sats ; $(PATS2XHTML) -o $@ -s $<
%_dats.html: %.dats ; $(PATS2XHTML) -o $@ -d $<
#
cleanall:: ; $(RMF) *_?ats.c
#
###### end of [Makefile] ######
