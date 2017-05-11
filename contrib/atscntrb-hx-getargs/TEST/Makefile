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

INCLUDE=./../..

######
#
all:: \
test00
test00: \
test00.dats ; \
$(PATSCC) \
-DATS_MEMALLOC_LIBC -I$(INCLUDE) -o $@ $<
#
regress:: test00; ./$<
cleanall:: ; $(RMF) test00
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
