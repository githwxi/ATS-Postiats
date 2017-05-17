#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

all::
regress::
cleanall::

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: test00; ./$<
cleanall:: ; $(RMF) test00
#
######
#
all:: \
test01
test01: \
test01.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: test01; ./$< --arg1 10 --arg2 10 --eval
cleanall:: ; $(RMF) test01
#
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

######

cleanall:: clean

###### end of [Makefile] ######
