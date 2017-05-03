#
# For generating
# syntax highlighting
#
######
#
# EMBED=--embedded
#
PATS2XHTML=$(PATSHOME)/bin/pats2xhtml $(EMBED)
#
######

all::

######

all:: all_sats
all:: all_dats

######

######
#
# SATS
#
######

all_sats:: \
qlist_sats.html
qlist_sats.html: \
./../SATS/qlist.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
sllist_sats.html
sllist_sats.html: \
./../SATS/sllist.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
stklist_sats.html
stklist_sats.html: \
./../SATS/stklist.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
stkarray_sats.html
stkarray_sats.html: \
./../SATS/stkarray.sats; $(PATS2XHTML) -o SATS/$@ --static $<

######

######
#
# DATS
#
######

all_dats:: \
qlist_dats.html
qlist_dats.html: \
./../DATS/qlist.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
sllist_dats.html
sllist_dats.html: \
./../DATS/sllist.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
stklist_dats.html
stklist_dats.html: \
./../DATS/stklist.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
stkarray_dats.html
stkarray_dats.html: \
./../DATS/stkarray.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

######
#
PHP=php
SCP=scp
MAKE=make
#
######
#
ATSLIBlibatsall0:: ; \
$(PHP) -f \
ATSLIB_libats_all_in_one_raw.php > ATSLIB_libats_all_in_one.raw
#
ATSLIBlibatsall1:: ; \
$(MAKE) EMBED=--embedded -f Makefile all
ATSLIBlibatsall2:: ; \
$(PHP) -f \
ATSLIB_libats_all_in_one_html.php > ATSLIB_libats_all_in_one.html
#
######

upload_all_in_one: ; \
$(SCP) \
ATSLIB_libats_all_in_one.raw \
ATSLIB_libats_all_in_one.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/libats/HTML/.

######

RMF=rm -f

######

clean:: ; $(RMF) *~

######

cleanall:: clean
cleanall:: ; $(RMF) *_ats.html
cleanall:: ; $(RMF) *_?ats.html
cleanall:: ; $(RMF) SATS/*_sats.html
cleanall:: ; $(RMF) DATS/*_dats.html
cleanall:: ; $(RMF) ATSLIB_libats_all_in_one.raw
cleanall:: ; $(RMF) ATSLIB_libats_all_in_one.html

######

###### end of [Makefile] ######
