#
# A Simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######
#
ATSCC2PHP=./../atscc2php
#
LIBATSCC2PHP=\
$(PATSHOME)/contrib/libatscc2php/ATS2-0.3.2
#
######

all::
regress::
cleanall::

######

all:: \
fact_dats.php
fact_dats.php: fact.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) fact_dats.php

######

all:: \
fact2_dats.php
fact2_dats.php: fact2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) fact2_dats.php

######

all:: \
fibats_dats.php
fibats_dats.php: fibats.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) fibats_dats.php

######

all:: \
acker_dats.php
acker_dats.php: acker.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) acker_dats.php

######

all:: \
isevn_dats.php
isevn_dats.php: isevn.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) isevn_dats.php

######

all:: \
weekday_dats.php
weekday_dats.php: weekday.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) weekday_dats.php

######

all:: \
multable_dats.php
multable_dats.php: multable.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) multable_dats.php

######

all:: \
twice_dats.php
twice_dats.php: twice.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) twice_dats.php

######

all:: \
rtfind_dats.php
rtfind_dats.php: rtfind.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) rtfind_dats.php

######

all:: \
rtfind2_dats.php
rtfind2_dats.php: rtfind2.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) rtfind2_dats.php

######

all:: \
queens_dats.php
queens_dats.php: queens.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) queens_dats.php

all:: \
queens_comb_dats.php
queens_comb_dats.php: queens_comb.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) queens_comb_dats.php

######

all:: \
refcount_dats.php
refcount_dats.php: refcount.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) refcount_dats.php

######

all:: \
sieve_lazy_dats.php
sieve_lazy_dats.php: sieve_lazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) sieve_lazy_dats.php

all:: \
sieve_llazy_dats.php
sieve_llazy_dats.php: sieve_llazy.dats ; \
$(PATSOPT) -d $< | $(ATSCC2PHP) -o $@
cleanall:: ; $(RMF) sieve_llazy_dats.php

######

regress:: \
mytestall
mytestall:: mytestall.php; php -f mytestall.php

######

testall:: all
testall:: regress
testall:: cleanall

######
#
CPF=cp -f
CPRF=cp -rf
#
RMF=rm -f
RMRF=rm -rf
#
######
#
libatscc2php:: ; \
$(CPRF) $(LIBATSCC2PHP)/CATS libatscc2php/.
libatscc2php:: ; \
$(CPRF) $(LIBATSCC2PHP)/output/DATS libatscc2php/.
#
######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) libatscc2php/libatscc2php_all.php
cleanall:: ; $(RMRF) libatscc2php/CATS
cleanall:: ; $(RMRF) libatscc2php/DATS

###### end of [Makefile] ######
