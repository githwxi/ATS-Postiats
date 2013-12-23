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
checkall:: listfun ; ./listfun
checkall:: mergesort ; ./mergesort
checkall:: ralist ; ./ralist
checkall:: rbtree ; ./rbtree

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

######

mergesort: mergesort.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) mergesort

######

ralist: ralist.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) ralist

######

rbtree: rbtree.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) rbtree

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
