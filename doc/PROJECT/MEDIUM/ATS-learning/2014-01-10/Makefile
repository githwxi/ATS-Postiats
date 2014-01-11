#
# A simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

all:: maxmin
maxmin: maxmin.dats ; $(PATSCC2) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) maxmin
cleanall:: ; $(RMF) maxmin_dats.c

######

include $(PATSHOME)/share/atsmake-post.mk

###### end of [Makefile] ######
