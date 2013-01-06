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

all_html:: HTML/list0.html
HTML/list0.html:   list0_atxt.exe ; ./$< > $@
list0_atxt.txt: list0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
list0_atxt.exe: htmlgendecl_atxt.dats   list0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_list0:: ;   scp HTML/list0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) list0_atxt.exe
cleanall:: ; $(RMF) HTML/list0.html

all_html:: HTML/option0.html
HTML/option0.html:   option0_atxt.exe ; ./$< > $@
option0_atxt.txt: option0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
option0_atxt.exe: htmlgendecl_atxt.dats   option0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_option0:: ;   scp HTML/option0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) option0_atxt.exe
cleanall:: ; $(RMF) HTML/option0.html

all_html:: HTML/array0.html
HTML/array0.html:   array0_atxt.exe ; ./$< > $@
array0_atxt.txt: array0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
array0_atxt.exe: htmlgendecl_atxt.dats   array0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_array0:: ;   scp HTML/array0.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) array0_atxt.exe
cleanall:: ; $(RMF) HTML/array0.html

all_html:: HTML/string.html
HTML/string.html:   string_atxt.exe ; ./$< > $@
string_atxt.txt: string.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
string_atxt.exe: htmlgendecl_atxt.dats   string_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_string:: ;   scp HTML/string.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) HTML/string.html


all_html:: HTML/filebas.html
HTML/filebas.html:   filebas_atxt.exe ; ./$< > $@
filebas_atxt.txt: filebas.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
filebas_atxt.exe: htmlgendecl_atxt.dats   filebas_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_filebas:: ;   scp HTML/filebas.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) HTML/filebas.html


all_html:: HTML/funmap.html
HTML/funmap.html:   funmap_atxt.exe ; ./$< > $@
funmap_atxt.txt: funmap.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funmap_atxt.exe: htmlgendecl_atxt.dats   funmap_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funmap:: ;   scp HTML/funmap.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) funmap_atxt.exe
cleanall:: ; $(RMF) HTML/funmap.html

all_html:: HTML/funset.html
HTML/funset.html:   funset_atxt.exe ; ./$< > $@
funset_atxt.txt: funset.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funset_atxt.exe: htmlgendecl_atxt.dats   funset_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funset:: ;   scp HTML/funset.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML
clean:: ; $(RMF) funset_atxt.exe
cleanall:: ; $(RMF) HTML/funset.html


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
