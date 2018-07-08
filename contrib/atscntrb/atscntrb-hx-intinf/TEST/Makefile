#
# A simple Makefile
#

######

PATSCC=patscc
PATSOPT=patsopt
PATSFIND=patsfind
PATSHOMEQ="$(PATSHOME)"

######
#
export \
PATSHOMELOCS=\
./node_modules:./../../node_modules
#
######

all::

######

CFLAGS:=
CFLAGS+=-I"./../.."
CFLAGS+=-DATS_MEMALLOC_LIBC

######

all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test01; ./$<
cleanall:: ; $(RMF) test01

######

all:: \
test02
test02: \
test02.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test02; ./$<
cleanall:: ; $(RMF) test02

######

all:: \
test03
test03: \
test03.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test03; ./$<
cleanall:: ; $(RMF) test03

######

all:: \
test04
test04: \
test04.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test04; ./$<
cleanall:: ; $(RMF) test04

######

all:: \
test05
test05: \
test05.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test05; ./$<
cleanall:: ; $(RMF) test05

######

all:: \
test06
test06: \
test06.dats ; \
$(PATSCC) -cleanaft $(CFLAGS) -o $@ $< -lgmp
regress:: test06; ./$<
cleanall:: ; $(RMF) test06

######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

cleanall:: clean

###### end of [Makefile] ######
