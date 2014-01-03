#
# A Simple Makefile
#

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

SOURCES_DATS += hello.dats

######

MYTARGET=hello

######
#
#rename if you want
MYPORTDIR=MYPORTDIR
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanall:: ; $(RMF) $(MYPORTDIR)/*
cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.o
cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.c

######

###### end of [Makefile] ######
