#
#
# A Simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

DBSRC= \
  chap_hello_atxt.db \
  chap_objtypes_atxt.db \
  chap_funtypes_atxt.db \
  chap_drawline_atxt.db \
  chap_drawrectcirc_atxt.db \
  chap_drawtext_atxt.db \

######

all:: html

######

pdf: main.db $(DBSRC) ; jw -b pdf --output PDF/ main.db
html: main.db $(DBSRC) ; jw -b html --output HTML/ main.db

######

chap_hello.exe: \
  chap_hello_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_hello_atxt.dats: \
  ATEXT/chap_hello.atxt; $(ATSDOC) --outcode $@ -i $< > chap_hello_atxt.txt
chap_hello_atxt.db: chap_hello.exe ; ./chap_hello.exe > $@
clean:: ; $(RMF) chap_hello.exe
cleanall:: ; $(RMF) chap_hello_atxt.*

######

chap_objtypes.exe: \
  chap_objtypes_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_objtypes_atxt.dats: \
  ATEXT/chap_objtypes.atxt; $(ATSDOC) --outcode $@ -i $< > chap_objtypes_atxt.txt
chap_objtypes_atxt.db: chap_objtypes.exe ; ./chap_objtypes.exe > $@
clean:: ; $(RMF) chap_objtypes.exe
cleanall:: ; $(RMF) chap_objtypes_atxt.*

######

chap_funtypes.exe: \
  chap_funtypes_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_funtypes_atxt.dats: \
  ATEXT/chap_funtypes.atxt; $(ATSDOC) --outcode $@ -i $< > chap_funtypes_atxt.txt
chap_funtypes_atxt.db: chap_funtypes.exe ; ./chap_funtypes.exe > $@
clean:: ; $(RMF) chap_funtypes.exe
cleanall:: ; $(RMF) chap_funtypes_atxt.*

######

chap_drawline.exe: \
  chap_drawline_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_drawline_atxt.dats: \
  ATEXT/chap_drawline.atxt; $(ATSDOC) --outcode $@ -i $< > chap_drawline_atxt.txt
chap_drawline_atxt.db: chap_drawline.exe ; ./chap_drawline.exe > $@
clean:: ; $(RMF) chap_drawline.exe
cleanall:: ; $(RMF) chap_drawline_atxt.*

######

chap_drawrectcirc.exe: \
  chap_drawrectcirc_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_drawrectcirc_atxt.dats: \
  ATEXT/chap_drawrectcirc.atxt; $(ATSDOC) --outcode $@ -i $< > chap_drawrectcirc_atxt.txt
chap_drawrectcirc_atxt.db: chap_drawrectcirc.exe ; ./chap_drawrectcirc.exe > $@
clean:: ; $(RMF) chap_drawrectcirc.exe
cleanall:: ; $(RMF) chap_drawrectcirc_atxt.*

######

chap_drawtext.exe: \
  chap_drawtext_atxt.dats; $(ATSCC) -D_ATS_GCATS -o $@ $< -latsdoc
chap_drawtext_atxt.dats: \
  ATEXT/chap_drawtext.atxt; $(ATSDOC) --outcode $@ -i $< > chap_drawtext_atxt.txt
chap_drawtext_atxt.db: chap_drawtext.exe ; ./chap_drawtext.exe > $@
clean:: ; $(RMF) chap_drawtext.exe
cleanall:: ; $(RMF) chap_drawtext_atxt.*

######

upload:: upload_html
upload_html: html; scp -r HTML/*.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2CAIRO/HTML

######

upload_code: ; scp -r CODE/*.dats \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2CAIRO/CODE
upload_image: ; scp -r IMAGE/*.png \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2CAIRO/IMAGE

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean
cleanall:: ; $(RMF) HTML/*.html
cleanall:: ; make -C CODE cleanall

###### end of [Makefile] ######
