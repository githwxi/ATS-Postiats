#
# A simple Makefile
#

######

GCC=gcc

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######
#
INCLUDE := -I./../..
#
#INCLUDE += -I$(PATSHOME)/contrib
#
######
#
LDFLAGS :=
#
# LDFLAGS += -L/usr/local/z3/bin
#
######

all::
regress::

######

all:: \
test00
test00: \
test00.dats ; $(PATSCC) $(INCLUDE) -o $@ $< $(LDFLAGS) -lz3
regress:: \
test00; ./test00
cleanall:: ; $(RMF) test00

######

all:: \
test01
test01: \
test01.dats ; $(PATSCC) $(INCLUDE) -o $@ $< $(LDFLAGS) -lz3
regress:: \
test01; ./test01
cleanall:: ; $(RMF) test01

######

all:: \
test02
test02: \
test02.dats ; $(PATSCC) $(INCLUDE) -o $@ $< $(LDFLAGS) -lz3
regress:: \
test02; ./test02
cleanall:: ; $(RMF) test02

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
