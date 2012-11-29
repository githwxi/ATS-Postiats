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

all_html:: HTML/gflist.html
HTML/gflist.html:   gflist_atxt.exe ; $(CAT) ../gflist.sats | ./$< > $@
gflist_atxt.txt: gflist.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_atxt.exe: htmlgendecl_atxt.dats   gflist_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gflist:: ;   scp HTML/gflist.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_atxt.exe
cleanall:: ; $(RMF) HTML/gflist.html

all_html:: HTML/gflist_vt.html
HTML/gflist_vt.html:   gflist_vt_atxt.exe ; $(CAT) ../gflist_vt.sats | ./$< > $@
gflist_vt_atxt.txt: gflist_vt.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
gflist_vt_atxt.exe: htmlgendecl_atxt.dats   gflist_vt_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_gflist_vt:: ;   scp HTML/gflist_vt.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) gflist_vt_atxt.exe
cleanall:: ; $(RMF) HTML/gflist_vt.html

all_html:: HTML/ilist_prf.html
HTML/ilist_prf.html:   ilist_prf_atxt.exe ; $(CAT) ../ilist_prf.sats | ./$< > $@
ilist_prf_atxt.txt: ilist_prf.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
ilist_prf_atxt.exe: htmlgendecl_atxt.dats   ilist_prf_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_ilist_prf:: ;   scp HTML/ilist_prf.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) ilist_prf_atxt.exe
cleanall:: ; $(RMF) HTML/ilist_prf.html

all_html:: HTML/funralist_nested.html
HTML/funralist_nested.html:   funralist_nested_atxt.exe ; $(CAT) ../funralist_nested.sats | ./$< > $@
funralist_nested_atxt.txt: funralist_nested.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
funralist_nested_atxt.exe: htmlgendecl_atxt.dats   funralist_nested_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_funralist_nested:: ;   scp HTML/funralist_nested.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) funralist_nested_atxt.exe
cleanall:: ; $(RMF) HTML/funralist_nested.html

all_html:: HTML/fundeque_fingertree.html
HTML/fundeque_fingertree.html:   fundeque_fingertree_atxt.exe ; $(CAT) ../fundeque_fingertree.sats | ./$< > $@
fundeque_fingertree_atxt.txt: fundeque_fingertree.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
fundeque_fingertree_atxt.exe: htmlgendecl_atxt.dats   fundeque_fingertree_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
upload_fundeque_fingertree:: ;   scp HTML/fundeque_fingertree.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats
clean:: ; $(RMF) fundeque_fingertree_atxt.exe
cleanall:: ; $(RMF) HTML/fundeque_fingertree.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
