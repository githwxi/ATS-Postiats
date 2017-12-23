######
#
# For generating libatscc2r34
#
######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2R34=$(PATSHOME)/bin/atscc2r34

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
$(ATSCC2R34) -o ./output/DATS/list_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2R34) -o ./output/DATS/option_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2R34) -o ./output/DATS/stream_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2R34) -o ./output/DATS/stream_vt_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2R34) -o ./output/DATS/intrange_dats.R -i
#
######

all:: ; \
$(PATSOPT) -d ./DATS/R34vector.dats | \
$(ATSCC2R34) -o ./output/DATS/R34vector_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/R34dframe.dats | \
$(ATSCC2R34) -o ./output/DATS/R34dframe_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/R34matrix.dats | \
$(ATSCC2R34) -o ./output/DATS/R34matrix_dats.R -i

######
#
all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2R34) -o ./output/DATS/ML/list0_dats.R -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/option0.dats | \
$(ATSCC2R34) -o ./output/DATS/ML/option0_dats.R -i
#
######
#
LIBATSCC2R34_ALL_R34=\
output/libatscc2r34_all.R
#
######

all_in_one:: libatscc2r34_all

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2r34_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2R34_ALL_R34)
#
libatscc2r34_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '######\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '# Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
($(PRINTF) '# ' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34); $(DATE) | $(CAT) - >>$(LIBATSCC2R34_ALL_R34))
libatscc2r34_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '######\n\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
#
######

libatscc2r34_all:: ; \
$(PRINTF) '######\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) 'assign("libatscc2r34.is.loaded", TRUE)\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '######\n\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)

######

libatscc2r34_all:: ; \
$(CAT) >>$(LIBATSCC2R34_ALL_R34) \
CATS/basics_cats.R \
CATS/integer_cats.R \
CATS/bool_cats.R \
CATS/float_cats.R \
CATS/R34vector_cats.R \
CATS/R34dframe_cats.R \
CATS/R34matrix_cats.R \

libatscc2r34_all:: ; \
$(CAT) >>$(LIBATSCC2R34_ALL_R34) \
output/DATS/list_dats.R \
output/DATS/option_dats.R \
output/DATS/stream_dats.R \
output/DATS/stream_vt_dats.R \
output/DATS/intrange_dats.R \
output/DATS/R34vector_dats.R \
output/DATS/R34dframe_dats.R \
output/DATS/R34matrix_dats.R \
output/DATS/ML/list0_dats.R \
output/DATS/ML/option0_dats.R \

######
#
libatscc2r34_all:: ; \
$(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '## ###### ###### ##' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
libatscc2r34_all:: ; \
$(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
#
libatscc2r34_all:: ; \
$(PRINTF) '\n## end of [libatscc2r34_all.R] ##\n' | $(CAT) - >>$(LIBATSCC2R34_ALL_R34)
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) output/DATS/*_dats.R
cleanall:: ; $(RMF) output/DATS/ML/*_dats.R
cleanall:: ; $(RMF) $(LIBATSCC2R34_ALL_R34)

######

###### end of [Makefile] ######
