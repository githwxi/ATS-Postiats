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

all: html

######

cleanall::

######

html: main.db
	jw -b html --output HTML/ main.db

pdf: main.db
	jw -b pdf --output PDF/ main.db

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

allchap:: CHAPTER_START
allchap:: CHAPTER_EOP
allchap:: CHAPTER_FUNCTIONS
allchap:: CHAPTER_DATATYPES
allchap:: CHAPTER_POLYMORPHISM
#allchap:: CHAPTER_SUMMARY_basic
allchap:: CHAPTER_EFFECTFUL
allchap:: CHAPTER_CONVENIENCE
allchap:: CHAPTER_MODULARITY
allchap:: CHAPTER_LIBRARIES
allchap:: CHAPTER_CINTERACT
#allchap:: CHAPTER_SUMMARY_practical
allchap:: CHAPTER_DEPTYPES
allchap:: CHAPTER_DEPREFDTS
allchap:: CHAPTER_THMPRVING
allchap:: CHAPTER_PwTP
allchap:: CHAPTER_VVTINTRO
allchap:: CHAPTER_DATAVIEWS
allchap:: CHAPTER_DATAVTYPES
allchap:: CHAPTER_ABSVTYPES

CHAPTER_START:: ; \
  make -C CHAPTER_START -f ../Makefile.chap main.db
CHAPTER_START:: ; \
  make -C CHAPTER_START -f ../Makefile.chap clean

CHAPTER_EOP:: ; \
  make -C CHAPTER_EOP -f ../Makefile.chap main.db
CHAPTER_EOP:: ; \
  make -C CHAPTER_EOP -f ../Makefile.chap clean

CHAPTER_DATATYPES:: ; \
  make -C CHAPTER_DATATYPES -f ../Makefile.chap main.db
chapter_datatypes:: ; \
  make -C CHAPTER_DATATYPES -f ../Makefile.chap clean

chapter_functions:: ; \
  make -C CHAPTER_FUNCTIONS -f ../Makefile.chap main.db
chapter_functions:: ; \
  make -C CHAPTER_FUNCTIONS -f ../Makefile.chap clean

CHAPTER_POLYMORPHISM:: ; \
  make -C CHAPTER_POLYMORPHISM -f ../Makefile.chap main.db
CHAPTER_POLYMORPHISM:: ; \
  make -C CHAPTER_POLYMORPHISM -f ../Makefile.chap clean

CHAPTER_CONVENIENCE:: ; \
  make -C CHAPTER_CONVENIENCE -f ../Makefile.chap main.db
CHAPTER_CONVENIENCE:: ; \
  make -C CHAPTER_CONVENIENCE -f ../Makefile.chap clean

CHAPTER_EFFECTFUL:: ; \
  make -C CHAPTER_EFFECTFUL -f ../Makefile.chap main.db
CHAPTER_EFFECTFUL:: ; \
  make -C CHAPTER_EFFECTFUL -f ../Makefile.chap clean

CHAPTER_MODULARITY:: ; \
  make -C CHAPTER_MODULARITY -f ../Makefile.chap main.db
CHAPTER_MODULARITY:: ; \
  make -C CHAPTER_MODULARITY -f ../Makefile.chap clean

CHAPTER_LIBRARIES:: ; \
  make -C CHAPTER_LIBRARIES -f ../Makefile.chap main.db
CHAPTER_LIBRARIES:: ; \
  make -C CHAPTER_LIBRARIES -f ../Makefile.chap clean

CHAPTER_CINTERACT:: ; \
  make -C CHAPTER_CINTERACT -f ../Makefile.chap main.db
CHAPTER_CINTERACT:: ; \
  make -C CHAPTER_CINTERACT -f ../Makefile.chap clean

CHAPTER_DEPTYPES:: ; \
  make -C CHAPTER_DEPTYPES -f ../Makefile.chap main.db
CHAPTER_DEPTYPES:: ; \
  make -C CHAPTER_DEPTYPES -f ../Makefile.chap clean

CHAPTER_DEPREFDTS:: ; \
  make -C CHAPTER_DEPREFDTS -f ../Makefile.chap main.db
CHAPTER_DEPREFDTS:: ; \
  make -C CHAPTER_DEPREFDTS -f ../Makefile.chap clean

CHAPTER_THMPRVING:: ; \
  make -C CHAPTER_THMPRVING -f ../Makefile.chap main.db
CHAPTER_THMPRVING:: ; \
  make -C CHAPTER_THMPRVING -f ../Makefile.chap clean

CHAPTER_PwTP:: ; \
  make -C CHAPTER_PwTP -f ../Makefile.chap main.db
CHAPTER_PwTP:: ; \
  make -C CHAPTER_PwTP -f ../Makefile.chap clean

CHAPTER_VVTINTRO:: ; \
  make -C CHAPTER_VVTINTRO -f ../Makefile.chap main.db
CHAPTER_VVTINTRO:: ; \
  make -C CHAPTER_VVTINTRO -f ../Makefile.chap clean

CHAPTER_DATAVIEWS:: ; \
  make -C CHAPTER_DATAVIEWS -f ../Makefile.chap main.db
CHAPTER_DATAVIEWS:: ; \
  make -C CHAPTER_DATAVIEWS -f ../Makefile.chap clean

CHAPTER_DATAVTYPES:: ; \
  make -C CHAPTER_DATAVTYPES -f ../Makefile.chap main.db
CHAPTER_DATAVTYPES:: ; \
  make -C CHAPTER_DATAVTYPES -f ../Makefile.chap clean

CHAPTER_ABSVTYPES:: ; \
  make -C CHAPTER_ABSVTYPES -f ../Makefile.chap main.db
CHAPTER_ABSVTYPES:: ; \
  make -C CHAPTER_ABSVTYPES -f ../Makefile.chap clean

######

upload:
	scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS

upload_pdf:
	scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/

uploadloc:
	cp -rf HTML $(HOME)/public_html/ATS/DOCUMENT/INTPROGINATS
	chmod 644 $(HOME)/public_html/ATS/DOCUMENT/INTPROGINATS/HTML/*.html

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
