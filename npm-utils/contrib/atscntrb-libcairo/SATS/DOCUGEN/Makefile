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

all_html:: HTML/cairo.html
HTML/cairo.html:   cairo_atxt.exe ; ./$< > $@
cairo_atxt.txt: cairo.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo_atxt.exe: htmlgendecl_atxt.dats   cairo_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo:: ;   scp HTML/cairo.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo_atxt.exe
cleanall:: ; $(RMF) HTML/cairo.html

all_html:: HTML/mybasis.html
HTML/mybasis.html:   mybasis_atxt.exe ; ./$< > $@
mybasis_atxt.txt: mybasis.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
mybasis_atxt.exe: htmlgendecl_atxt.dats   mybasis_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_mybasis:: ;   scp HTML/mybasis.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) mybasis_atxt.exe
cleanall:: ; $(RMF) HTML/mybasis.html

all_html:: HTML/cairo-cairo-t.html
HTML/cairo-cairo-t.html:   cairo-cairo-t_atxt.exe ; ./$< > $@
cairo-cairo-t_atxt.txt: cairo-cairo-t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-cairo-t_atxt.exe: htmlgendecl_atxt.dats   cairo-cairo-t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-cairo-t:: ;   scp HTML/cairo-cairo-t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-cairo-t_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-cairo-t.html

all_html:: HTML/cairo-Paths.html
HTML/cairo-Paths.html:   cairo-Paths_atxt.exe ; ./$< > $@
cairo-Paths_atxt.txt: cairo-Paths.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-Paths_atxt.exe: htmlgendecl_atxt.dats   cairo-Paths_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-Paths:: ;   scp HTML/cairo-Paths.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-Paths_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-Paths.html

all_html:: HTML/cairo-Regions.html
HTML/cairo-Regions.html:   cairo-Regions_atxt.exe ; ./$< > $@
cairo-Regions_atxt.txt: cairo-Regions.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-Regions_atxt.exe: htmlgendecl_atxt.dats   cairo-Regions_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-Regions:: ;   scp HTML/cairo-Regions.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-Regions_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-Regions.html

all_html:: HTML/cairo-cairo-pattern-t.html
HTML/cairo-cairo-pattern-t.html:   cairo-cairo-pattern-t_atxt.exe ; ./$< > $@
cairo-cairo-pattern-t_atxt.txt: cairo-cairo-pattern-t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-cairo-pattern-t_atxt.exe: htmlgendecl_atxt.dats   cairo-cairo-pattern-t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-cairo-pattern-t:: ;   scp HTML/cairo-cairo-pattern-t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-cairo-pattern-t_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-cairo-pattern-t.html

all_html:: HTML/cairo-Transformations.html
HTML/cairo-Transformations.html:   cairo-Transformations_atxt.exe ; ./$< > $@
cairo-Transformations_atxt.txt: cairo-Transformations.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-Transformations_atxt.exe: htmlgendecl_atxt.dats   cairo-Transformations_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-Transformations:: ;   scp HTML/cairo-Transformations.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-Transformations_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-Transformations.html

all_html:: HTML/cairo-cairo-device-t.html
HTML/cairo-cairo-device-t.html:   cairo-cairo-device-t_atxt.exe ; ./$< > $@
cairo-cairo-device-t_atxt.txt: cairo-cairo-device-t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-cairo-device-t_atxt.exe: htmlgendecl_atxt.dats   cairo-cairo-device-t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-cairo-device-t:: ;   scp HTML/cairo-cairo-device-t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-cairo-device-t_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-cairo-device-t.html

all_html:: HTML/cairo-cairo-surface-t.html
HTML/cairo-cairo-surface-t.html:   cairo-cairo-surface-t_atxt.exe ; ./$< > $@
cairo-cairo-surface-t_atxt.txt: cairo-cairo-surface-t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-cairo-surface-t_atxt.exe: htmlgendecl_atxt.dats   cairo-cairo-surface-t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-cairo-surface-t:: ;   scp HTML/cairo-cairo-surface-t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-cairo-surface-t_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-cairo-surface-t.html

all_html:: HTML/cairo-Image-Surfaces.html
HTML/cairo-Image-Surfaces.html:   cairo-Image-Surfaces_atxt.exe ; ./$< > $@
cairo-Image-Surfaces_atxt.txt: cairo-Image-Surfaces.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-Image-Surfaces_atxt.exe: htmlgendecl_atxt.dats   cairo-Image-Surfaces_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-Image-Surfaces:: ;   scp HTML/cairo-Image-Surfaces.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-Image-Surfaces_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-Image-Surfaces.html

all_html:: HTML/cairo-PDF-Surfaces.html
HTML/cairo-PDF-Surfaces.html:   cairo-PDF-Surfaces_atxt.exe ; ./$< > $@
cairo-PDF-Surfaces_atxt.txt: cairo-PDF-Surfaces.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-PDF-Surfaces_atxt.exe: htmlgendecl_atxt.dats   cairo-PDF-Surfaces_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-PDF-Surfaces:: ;   scp HTML/cairo-PDF-Surfaces.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-PDF-Surfaces_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-PDF-Surfaces.html

all_html:: HTML/cairo-PNG-Support.html
HTML/cairo-PNG-Support.html:   cairo-PNG-Support_atxt.exe ; ./$< > $@
cairo-PNG-Support_atxt.txt: cairo-PNG-Support.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-PNG-Support_atxt.exe: htmlgendecl_atxt.dats   cairo-PNG-Support_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-PNG-Support:: ;   scp HTML/cairo-PNG-Support.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-PNG-Support_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-PNG-Support.html

all_html:: HTML/cairo-PostScript-Surfaces.html
HTML/cairo-PostScript-Surfaces.html:   cairo-PostScript-Surfaces_atxt.exe ; ./$< > $@
cairo-PostScript-Surfaces_atxt.txt: cairo-PostScript-Surfaces.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-PostScript-Surfaces_atxt.exe: htmlgendecl_atxt.dats   cairo-PostScript-Surfaces_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-PostScript-Surfaces:: ;   scp HTML/cairo-PostScript-Surfaces.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-PostScript-Surfaces_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-PostScript-Surfaces.html

all_html:: HTML/cairo-cairo-matrix-t.html
HTML/cairo-cairo-matrix-t.html:   cairo-cairo-matrix-t_atxt.exe ; ./$< > $@
cairo-cairo-matrix-t_atxt.txt: cairo-cairo-matrix-t.atxt ; $(CAT) $< |   $(ATSDOC) --prefix __datatok --outcode htmlgendecl_data_atxt.dats > $@
cairo-cairo-matrix-t_atxt.exe: htmlgendecl_atxt.dats   cairo-cairo-matrix-t_atxt.txt $(DECLATEXT) $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -o $@ $<     $(DECLATEXT) $(HTMLGENDECL) $(LDPATH) -latsynmark -latsopt -latsdoc -lats -lgmp
upload_cairo-cairo-matrix-t:: ;   scp HTML/cairo-cairo-matrix-t.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/
clean:: ; $(RMF) cairo-cairo-matrix-t_atxt.exe
cleanall:: ; $(RMF) HTML/cairo-cairo-matrix-t.html


######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/contrib/cairo/SATS/DOCUGEN/HTML/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
