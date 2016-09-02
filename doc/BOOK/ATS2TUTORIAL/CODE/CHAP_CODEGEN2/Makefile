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
#
all:: \
expr_codegen2.hats
#
all:: expr
#
regress:: expr; ./expr
cleanall:: ; rm -f expr
#
######

expr: \
expr.sats expr.dats; \
$(PATSCC) -o expr expr.dats -DATS_MEMALLOC_LIBC

expr_codegen2.hats: \
expr.sats expr.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d expr.dats

######

absrec: absrec.dats; \
$(PATSCC) -o absrec absrec.dats -DATS_MEMALLOC_LIBC
absrec_codegen2.hats: absrec.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d absrec.dats

######
#
testall:: all
testall:: regress
testall:: cleanall
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) expr
cleanall:: ; $(RMF) expr_codegen2.hats
cleanall:: ; $(RMF) absrec
cleanall:: ; $(RMF) absrec_codegen2.hats

###### end of [Makefile] ######
