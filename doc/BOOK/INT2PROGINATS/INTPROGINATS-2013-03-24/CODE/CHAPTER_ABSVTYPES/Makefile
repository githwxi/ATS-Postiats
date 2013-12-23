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

checkall::

######

distclean:: cleanall

######

checkall:: mergesort
mergesort: mergesort.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< && ./$@
cleanall:: ; $(RMF) mergesort

checkall:: sobjptr
sobjptr: sobjptr.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $< -lrt && ./$@
cleanall:: ; $(RMF) sobjptr

checkall:: circbuf
circbuf: circbuf.sats circbuf.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ && ./$@
cleanall:: ; $(RMF) circbuf

checkall:: circbuf2
circbuf2: circbuf.sats circbuf2.dats
	$(ATSCC) $(ATSGCFLAG) $(ATSCCFLAGS) -o $@ $^ && ./$@
cleanall:: ; $(RMF) circbuf2

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
