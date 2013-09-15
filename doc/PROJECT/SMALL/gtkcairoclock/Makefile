#
# A Makefile for gtkcairoclock
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

all:: main0
main0: main0.dats myclock0.dats
	$(PATSCC) -I${PATSHOME}/contrib -o $@ $^ $(GTKFLAGS)
cleanall:: ; $(RMF) main0

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######

