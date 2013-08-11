#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

hwserver: hwserver.dats ; \
  $(PATSCC) -IIATS ${PATSHOME}/contrib -o $@  $< testlib.dats -lzmq
cleanall:: ; $(RMF) hwserver

hwclient: hwclient.dats ; \
  $(PATSCC) -IIATS ${PATSHOME}/contrib -o $@  $< testlib.dats -lzmq
cleanall:: ; $(RMF) hwclient

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
