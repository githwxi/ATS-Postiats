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
all:: test02
all:: test03
all:: test04

######

test00: test00.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@ $< -lpcre
cleanall:: ; $(RMF) test00

######

test01: test01.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@ $< testlib.dats -lpcre
cleanall:: ; $(RMF) test01

######

test02: test02.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@ $< testlib.dats -lpcre
cleanall:: ; $(RMF) test02

######

test03: test03.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@ $< testlib.dats -lpcre
cleanall:: ; $(RMF) test03

######

test04: test04.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@ $< testlib.dats -lpcre
cleanall:: ; $(RMF) test04

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
