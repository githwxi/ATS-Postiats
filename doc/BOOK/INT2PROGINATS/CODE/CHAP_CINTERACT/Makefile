##
##
## A simple Makefile for compiling ATS programs
##
##

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

ATSCCFLAGS=-O2

######

all: checkall cleanall

######

checkall:: misc ; ./misc

######

distclean:: cleanall

######

misc: misc_dats.c
	$(PATSCC) $(ATSCCFAGS) -o $@ $<
cleanall:: ; $(RMF) misc

######

%_dats.c: %.dats
	$(PATSCC) -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -ccats $< || touch $@

######

RMF=rm -f

######

clean:
	$(RMF) *~
	$(RMF) *_?ats.o
	$(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
