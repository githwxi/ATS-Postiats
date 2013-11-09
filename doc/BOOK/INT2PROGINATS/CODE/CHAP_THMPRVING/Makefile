#
# A simple Makefile
#

######

CCOPT=gcc -std=c99
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSCCFLAGS=

######

all:: misc
all:: tree
all:: brauntree

######

misc: misc.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) misc

tree: tree.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) tree

brauntree: brauntree.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
cleanall:: ; $(RMF) brauntree

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
