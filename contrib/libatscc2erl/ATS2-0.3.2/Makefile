#
# For generating libatscc2erl
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2ERL=$(PATSHOME)/bin/atscc2erl

######

PATSOPT2=$(PATSOPT) --tlcalopt-disable

######

CAT=cat
CPF=cp -f
RMF=rm -f

######

all::
all_in_one::

######
#
all:: ; \
$(PATSOPT2) -d ./DATS/basics.dats | \
$(ATSCC2ERL) -o ./output/DATS/basics_dats.hrl -i
#
all:: ; \
$(PATSOPT2) -d ./DATS/list.dats | \
$(ATSCC2ERL) -o ./output/DATS/list_dats.hrl -i
all:: ; \
$(PATSOPT2) -d ./DATS/option.dats | \
$(ATSCC2ERL) -o ./output/DATS/option_dats.hrl -i
all:: ; \
$(PATSOPT2) -d ./DATS/intrange.dats | \
$(ATSCC2ERL) -o ./output/DATS/intrange_dats.hrl -i
#
all:: ; \
$(PATSOPT2) -d ./DATS/ML/option0.dats | \
$(ATSCC2ERL) -o ./output/DATS/ML/option0_dats.hrl -i
#
######

LIBATSCC2ERL_ALL_HRL=\
output/libatscc2erl_all.hrl

######

all_in_one:: libatscc2erl_all

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2erl_all:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2ERL_ALL_HRL)
#
libatscc2erl_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) '%%' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) '\n%% ' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) 'Time of Generation:' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) '\n%% ' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(DATE) | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) '%%\n\n' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
#
######

libatscc2erl_all:: ; \
$(CAT) >>$(LIBATSCC2ERL_ALL_HRL) \
CATS/basics_cats.hrl \
CATS/integer_cats.hrl \
CATS/bool_cats.hrl \
CATS/float_cats.hrl \
CATS/print_cats.hrl \
CATS/reference_cats.hrl \

libatscc2erl_all:: ; \
$(CAT) >>$(LIBATSCC2ERL_ALL_HRL) \
CATS/Erlang/file_cats.hrl \

libatscc2erl_all:: ; \
$(CAT) >>$(LIBATSCC2ERL_ALL_HRL) \
output/DATS/basics_dats.hrl \
output/DATS/list_dats.hrl \
output/DATS/option_dats.hrl \
output/DATS/intrange_dats.hrl \
output/DATS/ML/option0_dats.hrl \

######
#
libatscc2erl_all:: ; \
$(PRINTF) '\n%% ****** ****** %%\n' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
libatscc2erl_all:: ; \
$(PRINTF) '\n%% end of [$(LIBATSCC2ERL_ALL_HRL)] %%\n' | $(CAT) - >>$(LIBATSCC2ERL_ALL_HRL)
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) output/DATS/*_?ats.hrl
cleanall:: ; $(RMF) output/DATS/ML/*_?ats.hrl
cleanall:: ; $(RMF) $(LIBATSCC2ERL_ALL_HRL)

######

###### end of [Makefile] ######
