#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk
include $(PATSHOME)/share/atsmake-post.mk

######

all::
all:: hwserver
all:: hwclient

######

hwserver: hwserver.dats ; \
  $(PATSCC2) -I${PATSHOME}/contrib -o $@  $< testlib.dats -lzmq
cleanall:: ; $(RMF) hwserver

hwclient: hwclient.dats ; \
  $(PATSCC2) -I${PATSHOME}/contrib -o $@  $< testlib.dats -lzmq
cleanall:: ; $(RMF) hwclient

######

RMF=rm -f

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
