##
##
## A simple Makefile for compiling ATS programs
##
##

######

include $(PATSHOME)/share/atsmake-pre.mk

######

all:: atview
atview: atview.dats; $(PATSCC2) -tcats -o $@ $< || touch $@
cleanall:: ; $(RMF) atview

######

include $(PATSHOME)/share/atsmake-post.mk

######

###### end of [Makefile] ######
