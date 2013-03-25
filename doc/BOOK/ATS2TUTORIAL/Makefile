#
#
# A Simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc
#LIBATSDOC=$(ATSHOMEQ)/libatsdoc

######

all::
all:: html

######

cleanall::

######

pdf: main.db
	jw -b pdf --output PDF/ main.db

html: main.db
	jw -b html --output HTML/ main.db

######

main.db:: allchap
main.db:: preface.db

######

preface: preface_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ preface_atxt.dats -latsdoc
preface_atxt.dats: preface.atxt
	$(ATSDOC) --outcode $@ -i preface.atxt > preface_atxt.txt
preface.db: preface ; ./preface > $@
clean:: ; $(RMF) preface

######

allchap:: CHAP_SYNCLR

######

CHAP_SYNCLR:: ; \
  make -C CHAP_SYNCLR -f ../Makefile.chap main.db
CHAP_SYNCLR:: ; \
  make -C CHAP_SYNCLR -f ../Makefile.chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

upload:: ; \
  scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL
uploadloc:: ; \
  $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS2TUTORIAL

upload_pdf:: ; \
  scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL/

######

upload_code:: ; \
  scp -r CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *_atxt_dats.c

cleanall:: clean
cleanall:: ; $(RMF) preface.db
cleanall:: ; $(RMF) HTML/*.html
cleanall:: ; $(RMF) PDF/main.pdf

###### end of [Makefile] ######
