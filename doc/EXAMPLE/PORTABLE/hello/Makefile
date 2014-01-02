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

<<<<<<< HEAD
CFLAGS += -O2
LDFLAGS += -lm 
=======
MYTARGET=hello
>>>>>>> upstream/master

######
#
#rename if you want
MYPORTDIR=MYPORTDIR
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.o
cleanats:: ; $(RMF) $(MYPORTDIR)/*_?ats.c

######

###### end of [Makefile] ######
