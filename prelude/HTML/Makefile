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

all:: all_top
all:: all_sats
all:: all_dats

######
#
# TOP
#
######

all_top:: \
fixity_ats.html
fixity_ats.html: ./../fixity.ats; $(PATS2XHTML) -o $@ --static $<

######

all_top:: \
basics_pre_sats.html
basics_pre_sats.html: ./../basics_pre.sats; $(PATS2XHTML) -o $@ --static $<
all_top:: \
basics_sta_sats.html
basics_sta_sats.html: ./../basics_sta.sats; $(PATS2XHTML) -o $@ --static $<
all_top:: \
basics_dyn_sats.html
basics_dyn_sats.html: ./../basics_dyn.sats; $(PATS2XHTML) -o $@ --static $<
all_top:: \
basics_gen_sats.html
basics_gen_sats.html: ./../basics_gen.sats; $(PATS2XHTML) -o $@ --static $<

######

all_top:: \
macrodef_sats.html
macrodef_sats.html: ./../macrodef.sats; $(PATS2XHTML) -o $@ --static $<
all_top:: \
lmacrodef_sats.html
lmacrodef_sats.html: ./../lmacrodef.sats; $(PATS2XHTML) -o $@ --static $<

######
#
# SATS
#
######

all_sats:: \
integer_sats.html
integer_sats.html: \
./../SATS/integer.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
pointer_sats.html
pointer_sats.html: \
./../SATS/pointer.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
memory_sats.html
memory_sats.html: ./../SATS/memory.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
bool_sats.html
bool_sats.html: ./../SATS/bool.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
char_sats.html
char_sats.html: ./../SATS/char.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
float_sats.html
float_sats.html: ./../SATS/float.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
string_sats.html
string_sats.html: ./../SATS/string.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
strptr_sats.html
strptr_sats.html: ./../SATS/strptr.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
integer_ptr_sats.html
integer_ptr_sats.html: ./../SATS/integer_ptr.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
integer_fixed_sats.html
integer_fixed_sats.html: ./../SATS/integer_fixed.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
unsafe_sats.html
unsafe_sats.html: ./../SATS/unsafe.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
checkast_sats.html
checkast_sats.html: ./../SATS/checkast.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
tuple_sats.html
tuple_sats.html: ./../SATS/tuple.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
reference_sats.html
reference_sats.html: ./../SATS/reference.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
filebas_sats.html
filebas_sats.html: ./../SATS/filebas.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
intrange_sats.html
intrange_sats.html: ./../SATS/intrange.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
list_sats.html
list_sats.html: ./../SATS/list.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
list_vt_sats.html
list_vt_sats.html: ./../SATS/list_vt.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
option_sats.html
option_sats.html: ./../SATS/option.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
option_vt_sats.html
option_vt_sats.html: ./../SATS/option_vt.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
stream_sats.html
stream_sats.html: ./../SATS/stream.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
stream_vt_sats.html
stream_vt_sats.html: ./../SATS/stream_vt.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
array_sats.html
array_sats.html: ./../SATS/array.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
arrayptr_sats.html
arrayptr_sats.html: ./../SATS/arrayptr.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
arrayref_sats.html
arrayref_sats.html: ./../SATS/arrayref.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
matrix_sats.html
matrix_sats.html: ./../SATS/matrix.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
matrixptr_sats.html
matrixptr_sats.html: ./../SATS/matrixptr.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
matrixref_sats.html
matrixref_sats.html: ./../SATS/matrixref.sats; $(PATS2XHTML) -o SATS/$@ --static $<

all_sats:: \
gprint_sats.html
gprint_sats.html: ./../SATS/gprint.sats; $(PATS2XHTML) -o SATS/$@ --static $<
all_sats:: \
tostring_sats.html
tostring_sats.html: ./../SATS/tostring.sats; $(PATS2XHTML) -o SATS/$@ --static $<

######
#
# DATS
#
######

all_dats:: \
basics_dats.html
basics_dats.html: ./../DATS/basics.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
integer_dats.html
integer_dats.html: ./../DATS/integer.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
pointer_dats.html
pointer_dats.html: ./../DATS/pointer.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
memory_dats.html
memory_dats.html: ./../DATS/memory.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
bool_dats.html
bool_dats.html: ./../DATS/bool.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
char_dats.html
char_dats.html: ./../DATS/char.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
float_dats.html
float_dats.html: ./../DATS/float.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
string_dats.html
string_dats.html: ./../DATS/string.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
strptr_dats.html
strptr_dats.html: ./../DATS/strptr.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

# all_dats:: \
# integer_ptr_dats.html
# integer_ptr_dats.html: ./../DATS/integer_ptr.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
# all_dats:: \
# integer_fixed_dats.html
# integer_fixed_dats.html: ./../DATS/integer_fixed.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
unsafe_dats.html
unsafe_dats.html: ./../DATS/unsafe.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
checkast_dats.html
checkast_dats.html: ./../DATS/checkast.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
tuple_dats.html
tuple_dats.html: ./../DATS/tuple.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
reference_dats.html
reference_dats.html: ./../DATS/reference.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
filebas_dats.html
filebas_dats.html: ./../DATS/filebas.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
intrange_dats.html
intrange_dats.html: ./../DATS/intrange.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
list_dats.html
list_dats.html: ./../DATS/list.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
list_vt_dats.html
list_vt_dats.html: ./../DATS/list_vt.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
option_dats.html
option_dats.html: ./../DATS/option.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
option_vt_dats.html
option_vt_dats.html: ./../DATS/option_vt.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
stream_dats.html
stream_dats.html: ./../DATS/stream.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
stream_vt_dats.html
stream_vt_dats.html: ./../DATS/stream_vt.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
array_dats.html
array_dats.html: ./../DATS/array.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
array_prf_dats.html
array_prf_dats.html: ./../DATS/array_prf.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
arrayptr_dats.html
arrayptr_dats.html: ./../DATS/arrayptr.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
arrayref_dats.html
arrayref_dats.html: ./../DATS/arrayref.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
matrix_dats.html
matrix_dats.html: ./../DATS/matrix.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
matrixptr_dats.html
matrixptr_dats.html: ./../DATS/matrixptr.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
matrixref_dats.html
matrixref_dats.html: ./../DATS/matrixref.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

all_dats:: \
gprint_dats.html
gprint_dats.html: ./../DATS/gprint.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<
all_dats:: \
tostring_dats.html
tostring_dats.html: ./../DATS/tostring.dats; $(PATS2XHTML) -o DATS/$@ --dynamic $<

######
#
PHP=php
SCP=scp
MAKE=make
#
######
#
ATSPREall0:: ; \
$(PHP) -f ATSPRE_all_in_one_raw.php > ATSPRE_all_in_one.raw
#
ATSPREall1:: ; \
$(MAKE) EMBED=--embedded -f Makefile all
ATSPREall2:: ; \
$(PHP) -f ATSPRE_all_in_one_html.php > ATSPRE_all_in_one.html
#
######

upload_top: ; \
$(SCP) \
fixity_ats.html \
basics_*_sats.html \
macrodef_sats.html \
lmacrodef_sats.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/prelude/HTML/.

######

upload_sats: ; \
$(SCP) SATS/*_sats.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/prelude/HTML/SATS/.

######

upload_dats: ; \
$(SCP) DATS/*_dats.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/prelude/HTML/DATS/.

######

upload_all_in_one: ; \
$(SCP) ATSPRE_all_in_one.raw ATSPRE_all_in_one.html \
ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-Postiats/prelude/HTML/.

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
cleanall:: ; $(RMF) ATSPRE_all_in_one.raw
cleanall:: ; $(RMF) ATSPRE_all_in_one.html

######

###### end of [Makefile] ######
