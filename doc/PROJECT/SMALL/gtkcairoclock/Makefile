#
# A Makefile for gtkcairoclock
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

all:: myclock0
myclock0: myclock0.dats
	$(PATSCC) -I${PATSHOME}/contrib -o $@ main.dats $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock0

######

all:: myclock1
myclock1: myclock1.dats
	$(PATSCC) -I${PATSHOME}/contrib -o $@ main.dats $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock1

######

all:: myclock2
myclock2: myclock2.dats
	$(PATSCC) -I${PATSHOME}/contrib -o $@ main.dats $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock2

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######

