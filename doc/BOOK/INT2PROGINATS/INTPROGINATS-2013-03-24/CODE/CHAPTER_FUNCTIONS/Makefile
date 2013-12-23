##
##
## A simple Makefile for compiling ATS programs
##
##

######

ATSUSRQ="$(ATSHOME)"
ifeq ($(ATSUSRQ),"")
ATSUSRQ="/usr"
endif # end of [ifeq]

######

ATSCC=$(ATSUSRQ)/bin/atscc
ATSOPT=$(ATSUSRQ)/bin/atsopt

######

ATSCCFLAGS=-O2
ATSGCFLAG=-D_ATS_GCATS

######

all: checkall cleanall

######

checkall:: misc ; ./misc
checkall:: coin ; ./coin
checkall:: queens ; ./queens
checkall:: bsearch ; ./bsearch

######

distclean:: cleanall

######

misc: misc.dats
	$(ATSCC) -O2 $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) misc

######

coin: coin.dats
	$(ATSCC) -O2 $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) coin

queens: queens.dats
	$(ATSCC) -O2 $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) queens

bsearch: bsearch.dats
	$(ATSCC) -O2 $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) bsearch

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
