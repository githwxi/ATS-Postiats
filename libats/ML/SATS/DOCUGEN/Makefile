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

all_html:: HTML/list0.html
HTML/list0.html:   list0_atxt.exe ; $(CAT) ../list0.sats | ./$< > $@
list0_atxt.txt: list0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
list0_atxt.exe: htmlgendecl_atxt.dats   list0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) list0_atxt.exe
cleanall:: ; $(RMF) HTML/list0.html

all_html:: HTML/option0.html
HTML/option0.html:   option0_atxt.exe ; $(CAT) ../option0.sats | ./$< > $@
option0_atxt.txt: option0.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
option0_atxt.exe: htmlgendecl_atxt.dats   option0_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) option0_atxt.exe
cleanall:: ; $(RMF) HTML/option0.html


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
