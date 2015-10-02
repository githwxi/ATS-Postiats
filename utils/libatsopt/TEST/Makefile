#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######
#
LDPATH :=
#
LDPATH += -L$(ATSHOME)/ccomp/lib
LDPATH += -L$(ATSHOME)/ccomp/lib64
#
LDPATH += -L$(PATSHOME)/src
#
######

patsopt: \
patsopt.dats; \
$(PATSCC) -I$(ATSRUNTIME) -o $@ $(ATSRUNTIME)/ats_prelude.c $< $(LDPATH) -latsopt -lats -lgmp

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f patsopt

###### end of [Makefile] ######
