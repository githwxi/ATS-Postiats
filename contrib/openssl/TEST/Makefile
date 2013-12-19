#
# A Simple Makefile
#

######

CCOPT=gcc

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CFLAGS :=

######

LDFLAGS :=
LDFLAGS += -lcrypto

######

all::
all:: test01
all:: test02

######

test01: test01.dats ; \
  $(PATSCC) -IIATS $(PATSHOMERELOCQ)/contrib -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test01

######

test02: test02.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -IIATS $(PATSHOMERELOCQ)/contrib -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test02

######

test03: test03.dats ; \
  $(PATSCC) -DATS_MEMALLOC_LIBC -IIATS $(PATSHOMERELOCQ)/contrib -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) test03

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

######

###### end of [Makefile] ######
