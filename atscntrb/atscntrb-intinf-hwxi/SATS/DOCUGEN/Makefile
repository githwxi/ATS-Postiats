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

SHAREDOCU=$(PATSHOMEQ)/share/DOCUGEN

######

LDPATH :=
LDPATH += -L$(PATSHOME)/utils/libatsopt
LDPATH += -L$(PATSHOME)/utils/libatsynmark

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(SHAREDOCU) -IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CAT=cat

######

all:: all_html

######

DECLATEXT= \
  declatext_sats.o \
  declatext_dats.o \

declatext_sats.o: ; \
  $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/declatext.sats
declatext_dats.o: ; \
  $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/declatext.dats

######

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: ; \
  $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/htmlgendecl.sats
htmlgendecl_dats.o: ; \
  $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $(SHAREDOCU)/htmlgendecl.dats

htmlgendecl_atxt.dats: ; \
  $(ATSDOC) --outcode $@ -i $(SHAREDOCU)/htmlgendecl.atxt > htmlgendecl_atxt.txt

######

all_html::

all_html:: HTML/intinf.html
HTML/intinf.html:   intinf_atxt.exe ; ./$< > $@
intinf_atxt.txt: intinf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_atxt.exe: htmlgendecl_atxt.dats   intinf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_intinf:: ;   scp HTML/intinf.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libats-hwxi/intinf/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) intinf_atxt.exe
cleanall:: ; $(RMF) HTML/intinf.html

all_html:: HTML/intinf_t.html
HTML/intinf_t.html:   intinf_t_atxt.exe ; ./$< > $@
intinf_t_atxt.txt: intinf_t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_t_atxt.exe: htmlgendecl_atxt.dats   intinf_t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_intinf_t:: ;   scp HTML/intinf_t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libats-hwxi/intinf/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) intinf_t_atxt.exe
cleanall:: ; $(RMF) HTML/intinf_t.html

all_html:: HTML/intinf_vt.html
HTML/intinf_vt.html:   intinf_vt_atxt.exe ; ./$< > $@
intinf_vt_atxt.txt: intinf_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_vt_atxt.exe: htmlgendecl_atxt.dats   intinf_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_intinf_vt:: ;   scp HTML/intinf_vt.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libats-hwxi/intinf/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) intinf_vt_atxt.exe
cleanall:: ; $(RMF) HTML/intinf_vt.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/libats-hwxi/intinf/SATS/DOCUGEN/HTML/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
