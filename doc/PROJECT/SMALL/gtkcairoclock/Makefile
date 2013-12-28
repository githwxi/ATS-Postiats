#
# A Makefile for gtkcairoclock
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSHOMERELOCQ=\"$(PATSHOMERELOC)\"

######

PATSCC2=$(PATSCC) -I$(PATSHOMERELOCQ)/contrib

######

include $(PATSHOME)/share/atsmake-post.mk

######

GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######

all:: myclock0
myclock0: myclock0.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock0

######

all:: myclock1
myclock1: myclock1.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock1

######

all:: myclock2
myclock2: myclock2.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock2

######

all:: myclock3
myclock3: myclock3.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock3

######

all:: myclock4
myclock4: myclock4.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) myclock4

######

all:: mytriangle
mytriangle: mytriangle.dats; $(PATSCC2) -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) mytriangle

######

all:: mypascal
mypascal: mypascal.dats; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $< $(GTKFLAGS)
cleanall:: ; $(RMF) mypascal

######

clean:: cleanats

######

###### end of [Makefile] ######
