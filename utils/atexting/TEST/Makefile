######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
LDFLAGS :=
LDFLAGS := -L$(ATSHOME)/ccomp/lib
LDFLAGS += -L$(ATSHOME)/ccomp/lib64
LDFLAGS += -L$(PATSHOME)/utils/libatsynmark
#
ATSRUNTIME=$(ATSHOME)/ccomp/runtime
#
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
$(PATSCC) -O2 -o $@ \
  -D_ATS_GCBDW -DATS_MEMALLOC_GCBDW \
  myatexting.dats $(ATEXTING_MYLIB) \
  $(ATSRUNTIME)/ats_prelude.c $(LDFLAGS) -latsynmark -lats -lgc
#
######
#
regress:: \
data.atxt ; \
./myatexting -o data_atxt.dats -i $<
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) myatexting
cleanall:: ; $(RMF) data_atxt.dats

###### end of [Makefile] ######
