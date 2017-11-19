#
# For generating libatscc2clj
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2CLJ=$(PATSHOME)/bin/atscc2clj

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
$(ATSCC2CLJ) -o ./output/DATS/basics_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2CLJ) -o ./output/DATS/list_dats.clj -i
all:: ; \
$(PATSOPT) -d ./DATS/list_vt.dats | \
$(ATSCC2CLJ) -o ./output/DATS/list_vt_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2CLJ) -o ./output/DATS/option_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2CLJ) -o ./output/DATS/stream_dats.clj -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2CLJ) -o ./output/DATS/stream_vt_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2CLJ) -o ./output/DATS/intrange_dats.clj -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/funarray.dats | \
$(ATSCC2CLJ) -o ./output/DATS/funarray_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2CLJ) -o ./output/DATS/slistref_dats.clj -i
#
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2CLJ) -o ./output/DATS/qlistref_dats.clj -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2CLJ) -o ./output/DATS/ML/list0_dats.clj -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/option0.dats | \
$(ATSCC2CLJ) -o ./output/DATS/ML/option0_dats.clj -i
#
######

LIBATSCC2CLJ_ALL_CLJ=\
output/libatscc2clj_all.clj

######

all_in_one:: libatscc2clj_all

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2clj_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2CLJ_ALL_CLJ)
#
libatscc2clj_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2CLJ_ALL_CLJ)
libatscc2clj_all:: ; \
$(PRINTF) ';;\n' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
libatscc2clj_all:: ; \
$(PRINTF) ';; Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
libatscc2clj_all:: ; \
$(PRINTF) ';; ' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ) && $(DATE) | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
libatscc2clj_all:: ; \
$(PRINTF) ';;\n\n' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
#
######
#
libatscc2clj_all:: ; \
$(CAT) >>$(LIBATSCC2CLJ_ALL_CLJ) \
CATS/basics_cats.clj \
CATS/integer_cats.clj \
CATS/bool_cats.clj \
CATS/float_cats.clj \
CATS/print_cats.clj \
CATS/reference_cats.clj
#
libatscc2clj_all:: ; \
$(CAT) >>$(LIBATSCC2CLJ_ALL_CLJ) \
CATS/filebas_cats.clj
#
libatscc2clj_all:: ; \
$(CAT) >>$(LIBATSCC2CLJ_ALL_CLJ) \
CATS/CLJlist_cats.clj
#
######

libatscc2clj_all:: ; \
$(CAT) >>$(LIBATSCC2CLJ_ALL_CLJ) \
output/DATS/list_dats.clj \
output/DATS/list_vt_dats.clj \
output/DATS/option_dats.clj \
output/DATS/stream_dats.clj \
output/DATS/stream_vt_dats.clj \
output/DATS/intrange_dats.clj \
output/DATS/funarray_dats.clj \
output/DATS/slistref_dats.clj \
output/DATS/qlistref_dats.clj \
output/DATS/ML/list0_dats.clj \
output/DATS/ML/option0_dats.clj \

######
#
libatscc2clj_all:: ; \
$(PRINTF) '\n;; ****** ****** ;;\n' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
libatscc2clj_all:: ; \
$(PRINTF) '\n;; end of [libatscc2clj_all.clj] ;;\n' | $(CAT) - >>$(LIBATSCC2CLJ_ALL_CLJ)
#
######
#
upload_source:: ; \
$(SCPR) \
basics_clj.sats \
staloadall.hats \
CATS SATS DATS \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2clj/.
#
upload_libatscc2clj:: ; \
$(SCPR) \
$(LIBATSCC2CLJ_ALL_CLJ) \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libatscc/libatscc2clj/.
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) $(LIBATSCC2CLJ_ALL_CLJ)

######

###### end of [Makefile] ######
