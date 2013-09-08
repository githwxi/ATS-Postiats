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

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

ATSGCFLAG=-D_ATS_GCATS

######

CAT=cat

######

all:: all_html

######

DECLATEXT= \
  declatext_sats.o \
  declatext_dats.o \

declatext_sats.o: \
  declatext.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
declatext_dats.o: \
  declatext.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

######

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: \
  htmlgendecl.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
htmlgendecl_dats.o: \
  htmlgendecl.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

htmlgendecl_atxt.dats: htmlgendecl.atxt ;   $(ATSDOC) --outcode $@ -i $< > htmlgendecl_atxt.txt

######

all_html::

all_html:: HTML/basis.html
HTML/basis.html:   basis_atxt.exe ; ./$< > $@
basis_atxt.txt: basis.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
basis_atxt.exe: htmlgendecl_atxt.dats   basis_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_basis:: ;   scp HTML/basis.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) basis_atxt.exe
cleanall:: ; $(RMF) HTML/basis.html


all_html:: HTML/list0.html
HTML/list0.html:   list0_atxt.exe ; ./$< > $@
list0_atxt.txt: list0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
list0_atxt.exe: htmlgendecl_atxt.dats   list0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_list0:: ;   scp HTML/list0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) list0_atxt.exe
cleanall:: ; $(RMF) HTML/list0.html

all_html:: HTML/option0.html
HTML/option0.html:   option0_atxt.exe ; ./$< > $@
option0_atxt.txt: option0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
option0_atxt.exe: htmlgendecl_atxt.dats   option0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_option0:: ;   scp HTML/option0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) option0_atxt.exe
cleanall:: ; $(RMF) HTML/option0.html

all_html:: HTML/array0.html
HTML/array0.html:   array0_atxt.exe ; ./$< > $@
array0_atxt.txt: array0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
array0_atxt.exe: htmlgendecl_atxt.dats   array0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_array0:: ;   scp HTML/array0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) array0_atxt.exe
cleanall:: ; $(RMF) HTML/array0.html

all_html:: HTML/string.html
HTML/string.html:   string_atxt.exe ; ./$< > $@
string_atxt.txt: string.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
string_atxt.exe: htmlgendecl_atxt.dats   string_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_string:: ;   scp HTML/string.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) HTML/string.html

all_html:: HTML/strarr.html
HTML/strarr.html:   strarr_atxt.exe ; ./$< > $@
strarr_atxt.txt: strarr.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
strarr_atxt.exe: htmlgendecl_atxt.dats   strarr_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_strarr:: ;   scp HTML/strarr.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) strarr_atxt.exe
cleanall:: ; $(RMF) HTML/strarr.html


all_html:: HTML/filebas.html
HTML/filebas.html:   filebas_atxt.exe ; ./$< > $@
filebas_atxt.txt: filebas.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
filebas_atxt.exe: htmlgendecl_atxt.dats   filebas_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_filebas:: ;   scp HTML/filebas.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) HTML/filebas.html

all_html:: HTML/stdlib.html
HTML/stdlib.html:   stdlib_atxt.exe ; ./$< > $@
stdlib_atxt.txt: stdlib.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
stdlib_atxt.exe: htmlgendecl_atxt.dats   stdlib_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_stdlib:: ;   scp HTML/stdlib.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) stdlib_atxt.exe
cleanall:: ; $(RMF) HTML/stdlib.html


all_html:: HTML/funset.html
HTML/funset.html:   funset_atxt.exe ; ./$< > $@
funset_atxt.txt: funset.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_atxt.exe: htmlgendecl_atxt.dats   funset_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funset:: ;   scp HTML/funset.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) funset_atxt.exe
cleanall:: ; $(RMF) HTML/funset.html

all_html:: HTML/funmap.html
HTML/funmap.html:   funmap_atxt.exe ; ./$< > $@
funmap_atxt.txt: funmap.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_atxt.exe: htmlgendecl_atxt.dats   funmap_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_funmap:: ;   scp HTML/funmap.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) funmap_atxt.exe
cleanall:: ; $(RMF) HTML/funmap.html

all_html:: HTML/hashtbl.html
HTML/hashtbl.html:   hashtbl_atxt.exe ; ./$< > $@
hashtbl_atxt.txt: hashtbl.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
hashtbl_atxt.exe: htmlgendecl_atxt.dats   hashtbl_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_hashtbl:: ;   scp HTML/hashtbl.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) hashtbl_atxt.exe
cleanall:: ; $(RMF) HTML/hashtbl.html


all_html:: HTML/monad_list.html
HTML/monad_list.html:   monad_list_atxt.exe ; ./$< > $@
monad_list_atxt.txt: monad_list.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
monad_list_atxt.exe: htmlgendecl_atxt.dats   monad_list_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_monad_list:: ;   scp HTML/monad_list.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) monad_list_atxt.exe
cleanall:: ; $(RMF) HTML/monad_list.html

all_html:: HTML/monad_maybe.html
HTML/monad_maybe.html:   monad_maybe_atxt.exe ; ./$< > $@
monad_maybe_atxt.txt: monad_maybe.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
monad_maybe_atxt.exe: htmlgendecl_atxt.dats   monad_maybe_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsynmark/libatsynmark.a -latsdoc
upload_monad_maybe:: ;   scp HTML/monad_maybe.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) monad_maybe_atxt.exe
cleanall:: ; $(RMF) HTML/monad_maybe.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
