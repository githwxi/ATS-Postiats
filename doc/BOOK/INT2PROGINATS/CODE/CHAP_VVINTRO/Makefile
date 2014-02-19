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

include $(PATSHOME)/share/atsmake-post.mk

######

###### end of [Makefile] ######
