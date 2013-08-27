#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::

######

test00: test00.dats ; \
  $(PATSCC) -IIATS ${PATSHOME}/contrib -o $@  $< testlib.dats -lcurl
cleanall:: ; $(RMF) test00

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
