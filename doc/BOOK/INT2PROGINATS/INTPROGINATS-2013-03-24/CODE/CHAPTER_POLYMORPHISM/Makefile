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

ATSCCFLAGS=
ATSGCFLAG=-D_ATS_GCATS

######

all: checkall cleanall

######

checkall:: misc ; ./misc
checkall:: listfun ; ./listfun
checkall:: mergesort ; ./mergesort

######

distclean:: cleanall

######

misc: misc.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) misc

######

listfun: listfun.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) listfun

mergesort: mergesort.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) mergesort

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
