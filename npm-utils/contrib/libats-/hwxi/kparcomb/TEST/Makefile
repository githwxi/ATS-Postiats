######
#
#
# A simple Makefile
#
#
######

PATSCC=${PATSHOME}/bin/patscc
PATSOPT=${PATSHOME}/bin/patsopt

######

all:: 

######

all:: \
tokenizer
tokenizer: \
tokenizer.dats; \
$(PATSCC) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_GCBDW -O2 -o $@ $< ./../mylibies.dats -latslib -lgc

######

CAT=cat
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) tokenizer
#
###### end of [Makefile] ######
