#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSRUNTIME=$(ATSHOME)/ccomp/runtime

######
#
LDPATH :=
LDPATH += -L$(PATSHOME)/utils/libatsopt
#
######

LIBGMP=
LIBGMP=-lgmp

######
#
patsopt: \
patsopt.dats; \
$(PATSCC) -I$(ATSRUNTIME) \
  -o $@ $(ATSRUNTIME)/ats_prelude.c $< $(LDPATH) -latsopt $(LIBGMP)
#
######

patsopt_ccomp: \
patsopt_ccomp.dats; $(ATSCC) -o $@ $< $(LDPATH) -latsopt $(LIBGMP)

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f patsopt
cleanall:: ; rm -f patsopt_ccomp

###### end of [Makefile] ######
