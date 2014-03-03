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
cleanall:: ; $(RMF) atview

######

all:: dotprod
dotprod: dotprod.dats; $(PATSCC2) -o $@ $< || touch $@
cleanall:: ; $(RMF) dotprod

######

all:: stkclo
stkclo: stkclo.dats; $(PATSCC2) -o $@ $< || touch $@
cleanall:: ; $(RMF) stkclo

######

all:: cloptr
cloptr: cloptr.dats; $(PATSCC2) -DATS_MEMALLOC_LIBC -o $@ $< || touch $@
cleanall:: ; $(RMF) cloptr

######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
