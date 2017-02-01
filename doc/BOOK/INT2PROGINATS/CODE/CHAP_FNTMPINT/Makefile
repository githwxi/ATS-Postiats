##
##
## A simple Makefile for compiling ATS programs
##
##

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

CFLAGS :=
CFLAGS += -O2
CFLAGS += -D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######
#
all:: \
myprint
myprint: \
myprint.dats ; $(PATSCC) $(CFLAGS) -o $@ $< -lgmp
#
regress:: \
myprint ; ./myprint
#
cleanall:: ; $(RMF) myprint
#
######
#
all:: \
gnumber
gnumber: \
gnumber.dats ; \
$(PATSCC) $(CFLAGS) -I$(PATSHOME)/contrib -o $@ $< -lgmp
regress:: \
gnumber ; ./gnumber
#
cleanall:: ; $(RMF) gnumber
#
######
#
all:: \
loopcons
loopcons: \
loopcons.dats ; $(PATSCC) $(CFLAGS) -o $@ $<
#
regress:: \
loopcons ; ./loopcons
#
cleanall:: ; $(RMF) loopcons
#
######
#
all:: \
list_map
list_map: \
list_map.dats ; $(PATSCC) $(CFLAGS) -o $@ $<
#
regress:: \
list_map ; ./list_map
#
cleanall:: ; $(RMF) list_map
#
######

all:: \
intfloat
intfloat: \
intfloat.dats ; $(PATSCC) $(CFLAGS) -o $@ $<
regress:: \
intfloat ; ./intfloat
cleanall:: ; $(RMF) intfloat

######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
