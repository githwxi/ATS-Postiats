#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######
#
all:: \
maxmin
maxmin: \
maxmin.dats ; \
$(PATSCC2) -o $@ $< $(LDFLAGS)
#
regress:: maxmin ; ./$< 3 8
#
cleanall:: ; $(RMF) maxmin
cleanall:: ; $(RMF) maxmin_dats.c
#
######

testall:: all
testall:: regress
testall:: cleanall

######

include $(PATSHOME)/share/atsmake-post.mk

###### end of [Makefile] ######
