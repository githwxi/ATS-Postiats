#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

all::
all:: test00
all:: test01

######

test00: test00.dats ; \
  $(PATSCC) -I${PATSHOME}/contrib -o $@  $< testlib.dats -lcurl
cleanall:: ; $(RMF) test00

######

test01: test01.dats ; \
  $(PATSCC) -I${PATSHOME}/contrib -o $@  $< testlib.dats -lcurl
cleanall:: ; $(RMF) test01

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
