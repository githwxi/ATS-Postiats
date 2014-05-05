##
##
## A simple Makefile for compiling ATS programs
##
##

######

include $(PATSHOME)/share/atsmake-pre.mk

######

all:: atview
atview: atview.dats; $(PATSCC2) -o $@ $< || touch $@
regress:: atview; ./atview
cleanall:: ; $(RMF) atview

######

all:: dotprod
dotprod: dotprod.dats; $(PATSCC2) -o $@ $< || touch $@
regress:: dotprod; ./dotprod
cleanall:: ; $(RMF) dotprod

######

all:: stkclo
stkclo: stkclo.dats; $(PATSCC2) -o $@ $< || touch $@
regress:: stkclo; ./stkclo
cleanall:: ; $(RMF) stkclo

######

all:: cloptr
cloptr: cloptr.dats; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $< || touch $@
regress:: cloptr; ./cloptr
cleanall:: ; $(RMF) cloptr

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
