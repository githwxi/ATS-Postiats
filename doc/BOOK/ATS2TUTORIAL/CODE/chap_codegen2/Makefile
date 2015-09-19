#
# ATS2TUTORIAL
#

######
#
# Author: Hongwei Xi
# Authoremail: gmhwxiATgmailDOTcom
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

expr: \
expr.sats expr.dats; \
$(PATSCC) -o expr expr.dats -DATS_MEMALLOC_LIBC

expr_codegen2.hats: \
expr.sats expr.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d expr.dats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) expr
cleanall:: ; $(RMF) expr_codegen2.hats

###### end of [Makefile] ######
