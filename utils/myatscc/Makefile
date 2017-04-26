#
# A simple Makefile
#

######

NPM=npm

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

PATSCC2=\
$(PATSCC) -O2 \
-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######
#
export \
PATSHOMELOCS=\
./node_modules:./../../node_modules
#
######

all::
regress::
cleanall::

######

DATS_C =
DATS_C += myatscc_main_dats.c
DATS_C += myatscc_loc_t_dats.c
DATS_C += myatscc_lexer_dats.c
DATS_C += myatscc_parser_dats.c
DATS_C += myatscc_evaler_dats.c
DATS_C += myatscc_getdef_dats.c

PARCOMB =
PARCOMB += myatscc_parcomb.sats
PARCOMB += myatscc_parcomb.dats

MYLIBATS =
MYLIBATS += myatscc_libats.dats

######
#
all:: \
myatscc
#
myatscc: \
$(DATS_C); \
$(PATSCC2) -o $@ \
$(DATS_C) $(PARCOMB) $(MYLIBATS)
#
cleanall:: ; $(RMF) myatscc
#
######

%_dats.c: %.dats; $(PATSCC) -ccats $<

######
#
npm-install:: ; \
$(NPM) install atscntrb-hx-parcomb
#
######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######
#
cleanall:: clean
#
# cleanall:: ; $(RMF) -r node_modules
#
######

###### end of [Makefile] ######
