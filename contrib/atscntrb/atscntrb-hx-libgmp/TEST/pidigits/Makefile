######
#
# for SHOOTOUT/pidigits
#
######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
######

all::

######

INCLUDE=./../../..

######
#
all:: \
pidigits
pidigits: \
pidigits.dats ; \
$(PATSCC) -I$(INCLUDE) -O2 $< -o $@ -lgmp
#
regress:: \
pidigits; ./pidigits 1000
#
cleanall:: ; $(RMF) pidigits
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean

###### end of [Makefile] ######
