#
# For generating libatscc2py
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2PY=$(PATSHOME)/bin/atscc2py3

######

CAT=cat
CPF=cp -f
RMF=rm -f
SCPR=scp -r

######
#
all:: ; \
$(PATSOPT) -d ./DATS/string.dats | \
$(ATSCC2PY) -o ./output/DATS/string_dats.py -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/PYlist.dats | \
$(ATSCC2PY) -o ./output/DATS/PYlist_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/reference.dats | \
$(ATSCC2PY) -o ./output/DATS/reference_dats.py -i
#
all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2PY) -o ./output/DATS/list_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/list_vt.dats | \
$(ATSCC2PY) -o ./output/DATS/list_vt_dats.py -i
#
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2PY) -o ./output/DATS/option_dats.py -i
#
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2PY) -o ./output/DATS/stream_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2PY) -o ./output/DATS/stream_vt_dats.py -i
#
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2PY) -o ./output/DATS/intrange_dats.py -i
#
all:: ; \
$(PATSOPT) -d ./DATS/arrayref.dats | \
$(ATSCC2PY) -o ./output/DATS/arrayref_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/matrixref.dats | \
$(ATSCC2PY) -o ./output/DATS/matrixref_dats.py -i
#
######
#
all:: ; \
$(PATSOPT) -d ./DATS/funarray.dats | \
$(ATSCC2PY) -o ./output/DATS/funarray_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2PY) -o ./output/DATS/slistref_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2PY) -o ./output/DATS/qlistref_dats.py -i
#
######

all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2PY) -o ./output/DATS/ML/list0_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/array0.dats | \
$(ATSCC2PY) -o ./output/DATS/ML/array0_dats.py -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/option0.dats | \
$(ATSCC2PY) -o ./output/DATS/ML/option0_dats.py -i

######
#
LIBATSCC2PY3_ALL_PY=\
output/libatscc2py3_all.py
LIBATSCC2PY3_ALL_PYLIBC_PY=\
output/libatscc2py3_all_pylibc.py
LIBATSCC2PY3_ALL_PYGAME_PY=\
output/libatscc2py3_all_pygame.py
#
######

all_in_one:: libatscc2py3_all
all_in_one:: libatscc2py3_all_pylibc
all_in_one:: libatscc2py3_all_pygame

######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# libatscc2py3_all:: ; \
# $(ECHO) '\n' | $(CAT) - >$(LIBATSCC2PY3_ALL_PY)
#
libatscc2py3_all:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '######\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '# Time of Generation:\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
($(PRINTF) '# ' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY); $(DATE) | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY))
libatscc2py3_all:: ; \
$(PRINTF) '#\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '######\n\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
#
######

libatscc2py3_all:: ; \
$(CAT) >>$(LIBATSCC2PY3_ALL_PY) \
CATS/basics_cats.py \
CATS/integer_cats.py \
CATS/bool_cats.py \
CATS/char_cats.py \
CATS/float_cats.py \
CATS/string_cats.py \
CATS/print_cats.py \
CATS/filebas_cats.py \
CATS/PYlist_cats.py \
CATS/reference_cats.py \

######

libatscc2py3_all:: ; \
$(CAT) >>$(LIBATSCC2PY3_ALL_PY) \
output/DATS/string_dats.py \
output/DATS/PYlist_dats.py \
output/DATS/reference_dats.py \
output/DATS/list_dats.py \
output/DATS/list_vt_dats.py \
output/DATS/option_dats.py \
output/DATS/stream_dats.py \
output/DATS/stream_vt_dats.py \
output/DATS/intrange_dats.py \
output/DATS/arrayref_dats.py \
output/DATS/matrixref_dats.py \
output/DATS/funarray_dats.py \
output/DATS/slistref_dats.py \
output/DATS/qlistref_dats.py \
output/DATS/ML/list0_dats.py \
output/DATS/ML/array0_dats.py \
output/DATS/ML/option0_dats.py \

######
#
libatscc2py3_all:: ; \
$(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '## ###### ###### ##' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
libatscc2py3_all:: ; \
$(PRINTF) '\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
#
libatscc2py3_all:: ; \
$(PRINTF) '\n## end of [libatscc2py3_all.py] ##\n' | $(CAT) - >>$(LIBATSCC2PY3_ALL_PY)
#
######

libatscc2py3_all_pylibc:: ; \
$(CAT) >$(LIBATSCC2PY3_ALL_PYLIBC_PY) \
CATS/PYLIBC_random_cats.py \
CATS/PYLIBC_datetime_cats.py \

######

libatscc2py3_all_pygame:: ; \
$(CAT) >$(LIBATSCC2PY3_ALL_PYGAME_PY) \
CATS/PYGAME_pygame_cats.py \

######

clean:: ; $(RMF) *~ */*~

######
#
cleanall:: clean
#
cleanall:: ; rm -rf output/__pycache__
#
cleanall:: ; $(RMF) output/DATS/*_?ats.py
cleanall:: ; $(RMF) output/DATS/ML/*_?ats.py
#
cleanall:: ; $(RMF) $(LIBATSCC2PY3_ALL_PY)
cleanall:: ; $(RMF) $(LIBATSCC2PY3_ALL_PYLIBC_PY)
cleanall:: ; $(RMF) $(LIBATSCC2PY3_ALL_PYGAME_PY)
#
###### end of [Makefile] ######
