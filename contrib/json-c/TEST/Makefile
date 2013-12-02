#
# A simple Makefile
#

######

PATSCC=patscc
PATSHOMEQ="$(PATSHOME)"

######

CFLAGS :=
CFLAGS += -I${PATSHOMEQ}/contrib
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += $(shell pkg-config --libs json-c)

######

all::
all:: test00
all:: test01
all:: test02
all:: test03
all:: test04
all:: test05
all:: test06
all:: test07

######

test00: test00.dats ; \
  $(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -ljson-c
cleanall:: ; $(RMF) test00

######

test01: test01.dats ; \
  $(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -ljson-c
cleanall:: ; $(RMF) test01

######

test02: test02.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< -lgc -ljson-c
cleanall:: ; $(RMF) test02

######

test03: test03.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< -lgc -ljson-c
cleanall:: ; $(RMF) test03

######

test04: test04.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< -lgc -ljson-c
cleanall:: ; $(RMF) test04

######

test05: test05.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< -lgc -ljson-c
cleanall:: ; $(RMF) test05

######

test06: test06.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< -lgc -ljson-c
cleanall:: ; $(RMF) test06

######

test07: test07.dats ; \
  $(PATSCC) -cleanaft \
  -DATS_MEMALLOC_GCBDW $(CFLAGS) -o $@ $< testlib.dats -lgc -ljson-c
cleanall:: ; $(RMF) test07

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
