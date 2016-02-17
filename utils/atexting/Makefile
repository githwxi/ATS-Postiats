#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: atexting

######
#
MYLIB_DATS=atexting_mylib.dats
INCLUDE_ALL=atexting_include_all.dats
#
MYLIB_DATS_C=./CATS/atexting_mylib_dats.c
#
######
#
CFLAGS :=
CFLAGS += -O2
CFLAGS += -DATS_MEMALLOC_GCBDW
#
######
#
atexting: \
$(INCLUDE_ALL) \
$(MYLIB_DATS_C); \
$(PATSCC) $(CFLAGS) -o $@ $< $(MYLIB_DATS_C) -lgc
#
DATS_C:: \
$(MYLIB_DATS_C)
$(MYLIB_DATS_C): $(MYLIB_DATS); $(PATSOPT) -o $@ -d $<
#
######
#
testall:: all
testall:: cleanall
#
######

RMF=rm -f

######

clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) ./atexting
cleanall:: ; $(RMF) ./CATS/atexting_mylib_dats.c

###### end of [Makefile] ######
