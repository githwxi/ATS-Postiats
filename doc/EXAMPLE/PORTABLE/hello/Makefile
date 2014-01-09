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
MYPORTCPP=MYPORTCPP
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanall:: ; $(RMF) $(MYPORTDIR)/*
cleanats:: ; $(RMF) $(MYPORTDIR)/*_dats.c
cleanats:: ; $(RMF) $(MYPORTDIR)/*_dats.o

######

###### end of [Makefile] ######
