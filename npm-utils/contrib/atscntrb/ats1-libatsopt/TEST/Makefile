#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSOPT=$(ATSHOME)/bin/atsopt

######
#
LDPATH :=
LDPATH += -L./../ccomp/atslib/lib
#
######

LIBGMP=
LIBGMP=-lgmp

######

all:: patsopt
all:: patsopt_ccomp
all:: patsopt_atscc2js

######
#
patsopt: \
patsopt.dats; \
$(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)
#
######

patsopt_ccomp: \
patsopt_ccomp.dats; \
$(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)

######

patsopt_atscc2js: \
patsopt_atscc2js.dats; \
$(ATSCC) -o $@ $< $(LDPATH) -latsopt -lats $(LIBGMP)

######

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c

######

cleanall:: clean
cleanall:: ; rm -f patsopt
cleanall:: ; rm -f patsopt_ccomp
cleanall:: ; rm -f patsopt_atscc2js

###### end of [Makefile] ######
