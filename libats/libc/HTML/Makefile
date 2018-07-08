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
stdio_sats.html
stdio_sats.html: \
./../SATS/stdio.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
string_sats.html
string_sats.html: \
./../SATS/string.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
stdlib_sats.html
stdlib_sats.html: \
./../SATS/stdlib.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
unistd_sats.html
unistd_sats.html: \
./../SATS/unistd.sats; $(PATS2XHTML) -o SATS/$@ --static $<

######

######
#
# DATS
#
######

all_dats:: \
stdio_dats.html
stdio_dats.html: \
./../DATS/stdio.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
string_dats.html
string_dats.html: \
./../DATS/string.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
stdlib_dats.html
stdlib_dats.html: \
./../DATS/stdlib.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
unistd_dats.html
unistd_dats.html: \
./../DATS/unistd.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

######

######
#
PHP=php
SCP=scp
MAKE=make
#
######
#
ATSLIBlibatslibcall0:: ; \
$(PHP) -f ATSLIB_libats_libc_all_in_one_raw.php > ATSLIB_libats_libc_all_in_one.raw
#
ATSLIBlibatslibcall1:: ; \
$(MAKE) EMBED=--embedded -f Makefile all
ATSLIBlibatslibcall2:: ; \
$(PHP) -f ATSLIB_libats_libc_all_in_one_html.php > ATSLIB_libats_libc_all_in_one.html
#
######

upload_all_in_one: ; \
$(SCP) \
ATSLIB_libats_libc_all_in_one.raw \
ATSLIB_libats_libc_all_in_one.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/libats/libc/HTML/.

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
cleanall:: ; $(RMF) ATSLIB_libats_libc_all_in_one.raw
cleanall:: ; $(RMF) ATSLIB_libats_libc_all_in_one.html

######

###### end of [Makefile] ######
