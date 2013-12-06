#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc

######

all::
all:: test00
all:: test01

######

test00: test00.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@  $< testlib.dats -lcurl
cleanall:: ; $(RMF) test00

######

test01: test01.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@  $< testlib.dats -lcurl
cleanall:: ; $(RMF) test01

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
