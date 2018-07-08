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
tokenizer
regress:: \
tokenizer; $(CAT) tokenizer.dats | ./$< 
tokenizer: \
tokenizer.dats ; \
$(PATSCC) -O2 -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $< $(MYLIBIES)
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
cleanall:: ; $(RMF) tokenizer

###### end of [Makefile] ######
