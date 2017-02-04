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
LDPATH += -L$(PATSHOME)/ccomp/atslib/lib

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
all_html:: HTML/hiredis.html
HTML/hiredis.html:   hiredis_atxt.exe ; ./$< > $@
hiredis_atxt.txt: hiredis.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
hiredis_atxt.exe: htmlgendecl_atxt.dats   hiredis_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_hiredis:: ;   scp HTML/hiredis.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/hiredis/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) hiredis_atxt.exe
cleanall:: ; $(RMF) HTML/hiredis.html

all_html:: HTML/hiredis_ML.html
HTML/hiredis_ML.html:   hiredis_ML_atxt.exe ; ./$< > $@
hiredis_ML_atxt.txt: hiredis_ML.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
hiredis_ML_atxt.exe: htmlgendecl_atxt.dats   hiredis_ML_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_hiredis_ML:: ;   scp HTML/hiredis_ML.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/hiredis/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) hiredis_ML_atxt.exe
cleanall:: ; $(RMF) HTML/hiredis_ML.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/hiredis/SATS/DOCUGEN/HTML/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
