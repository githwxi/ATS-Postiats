#
# For generating libatscc2php
#

######

PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2PHP=$(PATSHOME)/bin/atscc2php

######

CAT=cat
CPF=cp -f
RMF=rm -f

######

all:: ; \
$(PATSOPT) -d ./DATS/list.dats | \
$(ATSCC2PHP) -o ./output/DATS/list_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/list_vt.dats | \
$(ATSCC2PHP) -o ./output/DATS/list_vt_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/option.dats | \
$(ATSCC2PHP) -o ./output/DATS/option_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/stream.dats | \
$(ATSCC2PHP) -o ./output/DATS/stream_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/stream_vt.dats | \
$(ATSCC2PHP) -o ./output/DATS/stream_vt_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/filebas.dats | \
$(ATSCC2PHP) -o ./output/DATS/filebas_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/intrange.dats | \
$(ATSCC2PHP) -o ./output/DATS/intrange_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/PHParray.dats | \
$(ATSCC2PHP) -o ./output/DATS/PHParray_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/PHParref.dats | \
$(ATSCC2PHP) -o ./output/DATS/PHParref_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/arrayref.dats | \
$(ATSCC2PHP) -o ./output/DATS/arrayref_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/reference.dats | \
$(ATSCC2PHP) -o ./output/DATS/reference_dats.php -i

######

all:: ; \
$(PATSOPT) -d ./DATS/slistref.dats | \
$(ATSCC2PHP) -o ./output/DATS/slistref_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/qlistref.dats | \
$(ATSCC2PHP) -o ./output/DATS/qlistref_dats.php -i

######

all:: ; \
$(PATSOPT) -d ./DATS/ML/list0.dats | \
$(ATSCC2PHP) -o ./output/DATS/ML/list0_dats.php -i
all:: ; \
$(PATSOPT) -d ./DATS/ML/array0.dats | \
$(ATSCC2PHP) -o ./output/DATS/ML/array0_dats.php -i

######
#
LIBATSCC2PHP_ALL_PHP=\
output/libatscc2php_all.php
#
######
#
DATE=/bin/date
ECHO=/bin/echo -en
#
PRINTF=printf
#
######
#
# all_in_one:: ; \
# $(ECHO) | $(CAT) - >$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; \
$(PRINTF) '\n' | $(CAT) - >$(LIBATSCC2PHP_ALL_PHP)
all_in_one:: ; \
$(PRINTF) '<?php\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; $(PRINTF) '/*\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; \
$(PRINTF) '** Time of Generation:\n** ' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; $(DATE) | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; $(PRINTF) '*/\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; $(PRINTF) '?>\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
######

all_in_one:: ; \
$(CAT) >>$(LIBATSCC2PHP_ALL_PHP) \
CATS/basics_cats.php \
CATS/integer_cats.php \
CATS/bool_cats.php \
CATS/float_cats.php \
CATS/string_cats.php \
CATS/print_cats.php \
CATS/filebas_cats.php \
CATS/PHPref_cats.php \
CATS/PHParray_cats.php \
CATS/PHParref_cats.php \

all_in_one:: ; \
$(CAT) >>$(LIBATSCC2PHP_ALL_PHP) \
output/DATS/list_dats.php \
output/DATS/list_vt_dats.php \
output/DATS/option_dats.php \
output/DATS/stream_dats.php \
output/DATS/stream_vt_dats.php \
output/DATS/filebas_dats.php \
output/DATS/intrange_dats.php \
output/DATS/PHParray_dats.php \
output/DATS/PHParref_dats.php \
output/DATS/arrayref_dats.php \
output/DATS/reference_dats.php \
output/DATS/slistref_dats.php \
output/DATS/qlistref_dats.php \
output/DATS/ML/list0_dats.php \
output/DATS/ML/array0_dats.php \

######
#
all_in_one:: ; \
$(PRINTF) '<?php\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; \
$(PRINTF) '/*\n** end of [$(LIBATSCC2PHP_ALL_PHP)]\n*/\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
all_in_one:: ; $(PRINTF) '?>\n' | $(CAT) - >>$(LIBATSCC2PHP_ALL_PHP)
#
######

clean:: ; $(RMF) *~ */*~

######

cleanall:: clean
cleanall:: ; $(RMF) output/DATS/*_?ats.php
cleanall:: ; $(RMF) output/DATS/ML/*_?ats.php
cleanall:: ; $(RMF) $(LIBATSCC2PHP_ALL_PHP)

######

###### end of [Makefile] ######
