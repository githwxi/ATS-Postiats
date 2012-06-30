#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"
INCLUDE=-I $(PATSHOMEQ)/src
INCLATS=-IATS $(PATSHOMEQ) -IATS $(PATSHOMEQ)/src

######

CAT=cat

######

all::

######

DECLATEXT= \
  declatext_sats.o \
  declatext_dats.o \

declatext_sats.o: \
  declatext.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
declatext_dats.o: \
  declatext.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: \
  htmlgendecl.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
htmlgendecl_dats.o: \
  htmlgendecl.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

######

htmlgendecl_atxt.dats: htmlgendecl.atxt ;   $(ATSDOC) --outcode $@ -i $< > htmlgendecl_atxt.txt

######

all:: HTML/arith_prf.html
HTML/arith_prf.html:   arith_prf_atxt.exe ; $(CAT) ../arith_prf.sats | ./$< > $@
arith_prf_atxt.txt: arith_prf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
arith_prf_atxt.exe: htmlgendecl_atxt.dats   arith_prf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) arith_prf_atxt.exe
cleanall:: ; $(RMF) HTML/arith_prf.html


all:: HTML/bool.html
HTML/bool.html:   bool_atxt.exe ; $(CAT) ../bool.sats | ./$< > $@
bool_atxt.txt: bool.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
bool_atxt.exe: htmlgendecl_atxt.dats   bool_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) bool_atxt.exe
cleanall:: ; $(RMF) HTML/bool.html

all:: HTML/char.html
HTML/char.html:   char_atxt.exe ; $(CAT) ../char.sats | ./$< > $@
char_atxt.txt: char.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
char_atxt.exe: htmlgendecl_atxt.dats   char_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) char_atxt.exe
cleanall:: ; $(RMF) HTML/char.html

all:: HTML/float.html
HTML/float.html:   float_atxt.exe ; $(CAT) ../float.sats | ./$< > $@
float_atxt.txt: float.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
float_atxt.exe: htmlgendecl_atxt.dats   float_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) float_atxt.exe
cleanall:: ; $(RMF) HTML/float.html

all:: HTML/integer.html
HTML/integer.html:   integer_atxt.exe ; $(CAT) ../integer.sats | ./$< > $@
integer_atxt.txt: integer.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
integer_atxt.exe: htmlgendecl_atxt.dats   integer_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) integer_atxt.exe
cleanall:: ; $(RMF) HTML/integer.html

all:: HTML/pointer.html
HTML/pointer.html:   pointer_atxt.exe ; $(CAT) ../pointer.sats | ./$< > $@
pointer_atxt.txt: pointer.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
pointer_atxt.exe: htmlgendecl_atxt.dats   pointer_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) pointer_atxt.exe
cleanall:: ; $(RMF) HTML/pointer.html

all:: HTML/reference.html
HTML/reference.html:   reference_atxt.exe ; $(CAT) ../reference.sats | ./$< > $@
reference_atxt.txt: reference.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
reference_atxt.exe: htmlgendecl_atxt.dats   reference_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) reference_atxt.exe
cleanall:: ; $(RMF) HTML/reference.html

all:: HTML/string.html
HTML/string.html:   string_atxt.exe ; $(CAT) ../string.sats | ./$< > $@
string_atxt.txt: string.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
string_atxt.exe: htmlgendecl_atxt.dats   string_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) HTML/string.html

all:: HTML/strptr.html
HTML/strptr.html:   strptr_atxt.exe ; $(CAT) ../strptr.sats | ./$< > $@
strptr_atxt.txt: strptr.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
strptr_atxt.exe: htmlgendecl_atxt.dats   strptr_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) strptr_atxt.exe
cleanall:: ; $(RMF) HTML/strptr.html


all:: HTML/filebas.html
HTML/filebas.html:   filebas_atxt.exe ; $(CAT) ../filebas.sats | ./$< > $@
filebas_atxt.txt: filebas.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
filebas_atxt.exe: htmlgendecl_atxt.dats   filebas_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) HTML/filebas.html


all:: HTML/array.html
HTML/array.html:   array_atxt.exe ; $(CAT) ../array.sats | ./$< > $@
array_atxt.txt: array.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
array_atxt.exe: htmlgendecl_atxt.dats   array_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) array_atxt.exe
cleanall:: ; $(RMF) HTML/array.html

all:: HTML/array_prf.html
HTML/array_prf.html:   array_prf_atxt.exe ; $(CAT) ../array_prf.sats | ./$< > $@
array_prf_atxt.txt: array_prf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
array_prf_atxt.exe: htmlgendecl_atxt.dats   array_prf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) array_prf_atxt.exe
cleanall:: ; $(RMF) HTML/array_prf.html

all:: HTML/arrayptr.html
HTML/arrayptr.html:   arrayptr_atxt.exe ; $(CAT) ../arrayptr.sats | ./$< > $@
arrayptr_atxt.txt: arrayptr.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
arrayptr_atxt.exe: htmlgendecl_atxt.dats   arrayptr_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) arrayptr_atxt.exe
cleanall:: ; $(RMF) HTML/arrayptr.html

all:: HTML/arrayref.html
HTML/arrayref.html:   arrayref_atxt.exe ; $(CAT) ../arrayref.sats | ./$< > $@
arrayref_atxt.txt: arrayref.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
arrayref_atxt.exe: htmlgendecl_atxt.dats   arrayref_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) arrayref_atxt.exe
cleanall:: ; $(RMF) HTML/arrayref.html


all:: HTML/list.html
HTML/list.html:   list_atxt.exe ; $(CAT) ../list.sats | ./$< > $@
list_atxt.txt: list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
list_atxt.exe: htmlgendecl_atxt.dats   list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) list_atxt.exe
cleanall:: ; $(RMF) HTML/list.html

all:: HTML/list_vt.html
HTML/list_vt.html:   list_vt_atxt.exe ; $(CAT) ../list_vt.sats | ./$< > $@
list_vt_atxt.txt: list_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
list_vt_atxt.exe: htmlgendecl_atxt.dats   list_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) list_vt_atxt.exe
cleanall:: ; $(RMF) HTML/list_vt.html


all:: HTML/option.html
HTML/option.html:   option_atxt.exe ; $(CAT) ../option.sats | ./$< > $@
option_atxt.txt: option.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
option_atxt.exe: htmlgendecl_atxt.dats   option_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) option_atxt.exe
cleanall:: ; $(RMF) HTML/option.html

all:: HTML/option_vt.html
HTML/option_vt.html:   option_vt_atxt.exe ; $(CAT) ../option_vt.sats | ./$< > $@
option_vt_atxt.txt: option_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
option_vt_atxt.exe: htmlgendecl_atxt.dats   option_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) option_vt_atxt.exe
cleanall:: ; $(RMF) HTML/option_vt.html


all:: HTML/unsafe.html
HTML/unsafe.html:   unsafe_atxt.exe ; $(CAT) ../unsafe.sats | ./$< > $@
unsafe_atxt.txt: unsafe.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
unsafe_atxt.exe: htmlgendecl_atxt.dats   unsafe_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) unsafe_atxt.exe
cleanall:: ; $(RMF) HTML/unsafe.html



all:: HTML/iterator.html
HTML/iterator.html:   iterator_atxt.exe ; $(CAT) ../iterator.sats | ./$< > $@
iterator_atxt.txt: iterator.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
iterator_atxt.exe: htmlgendecl_atxt.dats   iterator_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) iterator_atxt.exe
cleanall:: ; $(RMF) HTML/iterator.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/prelude

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
