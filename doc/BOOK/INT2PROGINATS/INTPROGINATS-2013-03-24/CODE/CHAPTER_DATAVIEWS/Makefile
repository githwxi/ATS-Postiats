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

checkall:: array
checkall:: sllst

######

distclean:: cleanall

######

array: array.dats
	$(ATSCC) -tc $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) array

sllst: sllst.dats
	$(ATSCC) -tc $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) sllst

quicksort: quicksort.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) quicksort

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
