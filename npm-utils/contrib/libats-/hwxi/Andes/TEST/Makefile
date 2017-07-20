#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

MYLIBIES :=
MYLIBIES += ./../mylibies.sats
MYLIBIES += ./../mylibies.dats

######
#
all:: \
test01
regress:: \
test01; $(CAT) test01.dats | ./$< 
test01: \
test01.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES) -lm
#
######

CAT=cat
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
cleanall:: ; $(RMF) test01

###### end of [Makefile] ######
