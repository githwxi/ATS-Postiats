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

######

test00: test00.dats ; \
  $(PATSCC) -I$(PATSHOMERELOCQ)/contrib -o $@  $< testlib.dats -lpcre
cleanall:: ; $(RMF) test00

######

test01: test01.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@  $< testlib.dats -lpcre
cleanall:: ; $(RMF) test01

######

test02: test02.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -I$(PATSHOMERELOCQ)/contrib -o $@  $< testlib.dats -lpcre
cleanall:: ; $(RMF) test02

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
