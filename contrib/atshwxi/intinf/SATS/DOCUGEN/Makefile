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

all_html:: HTML/intinf.html
HTML/intinf.html:   intinf_atxt.exe ; ./$< > $@
intinf_atxt.txt: intinf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_atxt.exe: htmlgendecl_atxt.dats   intinf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_intinf:: ;   scp HTML/intinf.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/atshwxi
clean:: ; $(RMF) intinf_atxt.exe
cleanall:: ; $(RMF) HTML/intinf.html

all_html:: HTML/intinf_t.html
HTML/intinf_t.html:   intinf_t_atxt.exe ; ./$< > $@
intinf_t_atxt.txt: intinf_t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_t_atxt.exe: htmlgendecl_atxt.dats   intinf_t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_intinf_t:: ;   scp HTML/intinf_t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/atshwxi
clean:: ; $(RMF) intinf_t_atxt.exe
cleanall:: ; $(RMF) HTML/intinf_t.html

all_html:: HTML/intinf_vt.html
HTML/intinf_vt.html:   intinf_vt_atxt.exe ; ./$< > $@
intinf_vt_atxt.txt: intinf_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
intinf_vt_atxt.exe: htmlgendecl_atxt.dats   intinf_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) $(ATSGCFLAG) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_intinf_vt:: ;   scp HTML/intinf_vt.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/atshwxi
clean:: ; $(RMF) intinf_vt_atxt.exe
cleanall:: ; $(RMF) HTML/intinf_vt.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/atshwxi

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
