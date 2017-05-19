#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######
#
all:: \
problem1
problem1: \
problem1.dats ; \
$(PATSCC2) -o $@ $< $(LDFLAGS)
#
cleanall:: ; $(RMF) problem1
cleanall:: ; $(RMF) problem1_dats.c
#
######

regress:: problem1 ; ./$<

######

testall:: all
testall:: regress
testall:: cleanall

######

include $(PATSHOME)/share/atsmake-post.mk

###### end of [Makefile] ######
