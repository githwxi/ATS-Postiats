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
misc: misc.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
regress:: misc; ./misc
cleanall:: ; $(RMF) misc

######

all:: tree
tree: tree.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
regress:: tree; ./tree
cleanall:: ; $(RMF) tree

######

all:: brauntree
brauntree: brauntree.dats; $(PATSCC) $(ATSCCFLAGS) -o $@ $<
regress:: brauntree; ./$<
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
