#
# For generating libatscc2scm
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2SCM=$(PATSHOME)/bin/atscc2scm

######

CAT=cat
CPF=cp -f
RMF=rm -f
SCPR=scp -r

######

all::
all_in_one::

######
#
all:: ; \
$(PATSOPT) -d ./DATS/basics.dats | \
$(ATSCC2SCM) -o ./output/DATS/basics_dats.scm -i
#
all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2SCM) -o ./output/DATS/list_dats.scm -i
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2SCM) -o ./output/DATS/option_dats.scm -i
#
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2SCM) -o ./output/DATS/stream_dats.scm -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2SCM) -o ./output/DATS/stream_vt_dats.scm -i
#
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2SCM) -o ./output/DATS/intrange_dats.scm -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/reference.dats | \
$(ATSCC2SCM) -o ./output/DATS/reference_dats.scm -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/funarray.dats | \
$(ATSCC2SCM) -o ./output/DATS/funarray_dats.scm -i
#
all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2SCM) -o ./output/DATS/slistref_dats.scm -i
#
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2SCM) -o ./output/DATS/qlistref_dats.scm -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2SCM) -o ./output/DATS/ML/list0_dats.scm -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/array0.dats | \
$(ATSCC2SCM) -o ./output/DATS/ML/array0_dats.scm -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/option0.dats | \
$(ATSCC2SCM) -o ./output/DATS/ML/option0_dats.scm -i
#
######

LIBATSCC2SCM_ALL_SCM=\
output/libatscc2scm_all.scm

######

all_in_one:: libatscc2scm_all

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2scm_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2SCM_ALL_SCM)
#
libatscc2scm_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2SCM_ALL_SCM)
libatscc2scm_all:: ; \
$(PRINTF) ';;\n' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
libatscc2scm_all:: ; \
$(PRINTF) ';; Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
libatscc2scm_all:: ; \
$(PRINTF) ';; ' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM) && $(DATE) | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
libatscc2scm_all:: ; \
$(PRINTF) ';;\n\n' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
#
######
#
libatscc2scm_all:: ; \
$(CAT) >>$(LIBATSCC2SCM_ALL_SCM) \
CATS/basics_cats.scm \
CATS/integer_cats.scm \
CATS/bool_cats.scm \
CATS/float_cats.scm \
CATS/print_cats.scm \
CATS/reference_cats.scm
#
libatscc2scm_all:: ; \
$(CAT) >>$(LIBATSCC2SCM_ALL_SCM) \
CATS/filebas_cats.scm
#
libatscc2scm_all:: ; \
$(CAT) >>$(LIBATSCC2SCM_ALL_SCM) \
CATS/SCMlist_cats.scm
#
######

libatscc2scm_all:: ; \
$(CAT) >>$(LIBATSCC2SCM_ALL_SCM) \
output/DATS/list_dats.scm \
output/DATS/option_dats.scm \
output/DATS/stream_dats.scm \
output/DATS/stream_vt_dats.scm \
output/DATS/intrange_dats.scm \
output/DATS/reference_dats.scm \
output/DATS/funarray_dats.scm \
output/DATS/slistref_dats.scm \
output/DATS/qlistref_dats.scm \
output/DATS/ML/list0_dats.scm \
output/DATS/ML/array0_dats.scm \
output/DATS/ML/option0_dats.scm \

######
#
libatscc2scm_all:: ; \
$(PRINTF) '\n;; ****** ****** ;;\n' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
libatscc2scm_all:: ; \
$(PRINTF) '\n;; end of [libatscc2scm_all.scm] ;;\n' | $(CAT) - >>$(LIBATSCC2SCM_ALL_SCM)
#
######
#
# upload_source:: ; \
# $(SCPR) \
# basics_scm.sats \
# staloadall.hats \
# CATS SATS DATS \
# ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2scm/.
#
# upload_libatscc2scm:: ; \
# $(SCPR) \
# $(LIBATSCC2SCM_ALL_SCM) \
# ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2scm/.
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) $(LIBATSCC2SCM_ALL_SCM)

######

###### end of [Makefile] ######
