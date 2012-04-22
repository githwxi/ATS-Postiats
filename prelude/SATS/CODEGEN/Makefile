#
#
# A simple Makefile for generating .sats files
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc
#LIBATSDOC=$(ATSHOMEQ)/libatsdoc

######

arrnull: arrnull_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ arrnull_atxt.dats -latsdoc
arrnull_atxt.dats: arrnull.atxt
	$(ATSDOC) -do $@ -i arrnull.atxt > arrnull_atxt.txt
arrnull.sats: arrnull ; ./arrnull > $@
clean:: ; $(RMF) arrnull
cleanall:: ; $(RMF) arrnull.sats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile] ######
