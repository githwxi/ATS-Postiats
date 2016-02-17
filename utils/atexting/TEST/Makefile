######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATEXTING_MYLIB=\
$(PATSHOME)/utils/atexting/atexting_mylib.dats
#
######

all:: myatexting

######
#
myatexting: \
myatexting.dats ; \
$(PATSCC) -O2 -o $@ $< \
  $(ATEXTING_MYLIB) -DATS_MEMALLOC_GCBDW -lgc
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) myatexting

###### end of [Makefile] ######
