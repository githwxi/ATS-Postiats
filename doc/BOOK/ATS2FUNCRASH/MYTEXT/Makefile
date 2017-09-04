######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
LDPATH :=
LDPATH := -L$(ATSHOME)/ccomp/lib
LDPATH += -L$(ATSHOME)/ccomp/lib64
# LDPATH += -L$(PATSHOME)/utils/libatsopt
# LDPATH += -L$(PATSHOME)/utils/libatsynmark
#
LIBRARY = -latsynmark -latsopt -lats -lgmp -lgc
#
ATSRUNTIME=$(ATSHOME)/ccomp/runtime
#
######

all:: mytexting

######
#
mytexting: \
mytexting.dats ; \
$(PATSCC) -verbose \
  -O2 -o bin/$@ mytexting.dats \
  -D_ATS_GCBDW -DATS_MEMALLOC_GCBDW \
  $(ATSRUNTIME)/ats_prelude.c $(LDPATH) $(LIBRARY)
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

######

cleanall:: clean
cleanall:: ; $(RMF) bin/mytexting

###### end of [Makefile] ######
