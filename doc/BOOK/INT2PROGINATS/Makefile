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

main.db: preface.db

######

preface: preface_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ preface_atxt.dats -latsdoc
preface_atxt.dats: preface.atxt
	$(ATSDOC) --outcode $@ -i preface.atxt > preface_atxt.txt
preface.db: preface ; ./preface > $@
clean:: ; $(RMF) preface

######

allchap:: CHAP_START

CHAP_START:: ; \
  make -C CHAP_START -f ../Makefile.chap main.db
CHAP_START:: ; \
  make -C CHAP_START -f ../Makefile.chap clean

######

CPRF=cp -rf
CHMOD=chmod

######

upload:
	scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS

upload_pdf:
	scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS/

uploadloc:
	$(CPRF) HTML $(HOME)/public_html/ATS/DOCUMENT/INT2PROGINATS
	$(CHMOD) 644 $(HOME)/public_html/ATS/DOCUMENT/INT2PROGINATS/HTML/*.html

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
