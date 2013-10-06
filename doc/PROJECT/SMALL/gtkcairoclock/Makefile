#
# A Makefile for gtkcairoclock
#

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ=\"$(PATSHOMERELOC)\"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

all:: myclock0
myclock0: myclock0.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock0

######

all:: myclock1
myclock1: myclock1.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock1

######

all:: myclock2
myclock2: myclock2.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock2

######

all:: myclock3
myclock3: myclock3.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock3

######

all:: myclock4
myclock4: myclock4.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock4

######

all:: mytriangle
mytriangle: mytriangle.dats
	$(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) mytriangle

######

all:: mypascal
mypascal: mypascal.dats
	$(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) mypascal

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######

