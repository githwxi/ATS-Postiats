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
checkall:: hello
checkall:: echo
checkall:: brauntest ; ./brauntest
checkall:: insort ; ./insort
checkall:: permord ; ./permord
checkall:: montecarlo ; ./montecarlo

######

distclean:: cleanall

######

misc: misc.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) misc

hello: hello.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) hello

echo: echo.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) echo

######

brauntest: brauntest.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) brauntest

insort: insort.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) insort

permord: permord.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< || touch $@
cleanall:: ; $(RMF) permord

montecarlo: montecarlo.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< -lm || touch $@
cleanall:: ; $(RMF) montecarlo

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c
	$(RMF) hello.txt

cleanall:: clean

###### end of [Makefile] ######
