#
# For generating libatscc2pl
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2PL=$(PATSHOME)/bin/atscc2pl

######

CAT=cat
CPF=cp -f
RMF=rm -f

######

all::
all_in_one::

######

all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2PL) -o ./output/DATS/list_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2PL) -o ./output/DATS/option_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2PL) -o ./output/DATS/stream_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2PL) -o ./output/DATS/stream_vt_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2PL) -o ./output/DATS/intrange_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/reference.dats | \
$(ATSCC2PL) -o ./output/DATS/reference_dats.pl -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/funarray.dats | \
$(ATSCC2PL) -o ./output/DATS/funarray_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2PL) -o ./output/DATS/slistref_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2PL) -o ./output/DATS/qlistref_dats.pl -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2PL) -o ./output/DATS/ML/list0_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/array0.dats | \
$(ATSCC2PL) -o ./output/DATS/ML/array0_dats.pl -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/option0.dats | \
$(ATSCC2PL) -o ./output/DATS/ML/option0_dats.pl -i
#
######
#
LIBATSCC2PL_ALL_PL=\
output/libatscc2pl_all.pl
#
######

all_in_one:: libatscc2pl_all

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2pl_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2PL_ALL_PL)
#
libatscc2pl_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; \
$(PRINTF) '######\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; \
$(PRINTF) '# Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; \
($(PRINTF) '# ' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL); $(DATE) | $(CAT) - >>$(LIBATSCC2PL_ALL_PL))
libatscc2pl_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; \
$(PRINTF) '######\n\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
#
######

libatscc2pl_all:: ; \
$(CAT) >>$(LIBATSCC2PL_ALL_PL) \
CATS/basics_cats.pl \
CATS/integer_cats.pl \
CATS/bool_cats.pl \
CATS/float_cats.pl \
CATS/string_cats.pl \
CATS/print_cats.pl \
CATS/PLarray_cats.pl \

libatscc2pl_all:: ; \
$(CAT) >>$(LIBATSCC2PL_ALL_PL) \
output/DATS/list_dats.pl \
output/DATS/option_dats.pl \
output/DATS/stream_dats.pl \
output/DATS/stream_vt_dats.pl \
output/DATS/intrange_dats.pl \
output/DATS/reference_dats.pl \
output/DATS/funarray_dats.pl \
output/DATS/slistref_dats.pl \
output/DATS/qlistref_dats.pl \
output/DATS/ML/list0_dats.pl \
output/DATS/ML/array0_dats.pl \
output/DATS/ML/option0_dats.pl \

######
#
libatscc2pl_all:: ; $(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; $(PRINTF) '## ###### ###### ##' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
libatscc2pl_all:: ; $(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
#
libatscc2pl_all:: ; \
  $(PRINTF) '\n## end of [libatscc2pl_all.pl] ##\n' | $(CAT) - >>$(LIBATSCC2PL_ALL_PL)
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) $(LIBATSCC2PL_ALL_PL)

######

###### end of [Makefile] ######
