include \
$(PATSHOME)/share/atsmake-pre.mk

######

all:: problem1
problem1: problem1.dats ; $(PATSCC) -o $@ $<
cleanall:: ; $(RMF) problem1

######

include $(PATSHOME)/share/atsmake-post.mk
