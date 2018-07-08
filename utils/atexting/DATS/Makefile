#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######
#
all:: \
atexting_fprint_token.hats
atexting_fprint_token.hats: atexting_token.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d atexting_token.dats
#
######
#
all:: \
atexting_fprint_atext.hats
atexting_fprint_atext.hats: atexting_atext.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d atexting_atext.dats
#
######
#
all:: \
atexting_fprint_commarg.hats
atexting_fprint_commarg.hats: atexting_commarg.dats; \
$(PATSOPT) -DATS CODEGEN2 --codegen-2 -o $@ -d atexting_commarg.dats
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
