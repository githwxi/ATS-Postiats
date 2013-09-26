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

preface.exe: preface_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ preface_atxt.dats -latsdoc
preface_atxt.dats: preface.atxt
	$(ATSDOC) --outcode $@ -i preface.atxt > preface_atxt.txt
preface.db:: preface.exe ; ./$< > $@
preface.db:: ; $(RMF) preface.exe preface_atxt_dats.c preface_atxt.dats preface_atxt.txt

######

allchap:: CHAP_SYNCLR
allchap:: CHAP_FILENAME
allchap:: CHAP_FILEINCL
allchap:: CHAP_FIXITY
allchap:: CHAP_HORDFUN
allchap:: CHAP_REFERENCE
allchap:: CHAP_ARRAYREF

######

CHAP_SYNCLR:: ; \
  make -C CHAP_SYNCLR -f ../Makefile.chap main.db
CHAP_SYNCLR:: ; \
  make -C CHAP_SYNCLR -f ../Makefile.chap clean

CHAP_FILENAME:: ; \
  make -C CHAP_FILENAME -f ../Makefile.chap main.db
CHAP_FILENAME:: ; \
  make -C CHAP_FILENAME -f ../Makefile.chap clean

CHAP_FILEINCL:: ; \
  make -C CHAP_FILEINCL -f ../Makefile.chap main.db
CHAP_FILEINCL:: ; \
  make -C CHAP_FILEINCL -f ../Makefile.chap clean

CHAP_FIXITY:: ; \
  make -C CHAP_FIXITY -f ../Makefile.chap main.db
CHAP_FIXITY:: ; \
  make -C CHAP_FIXITY -f ../Makefile.chap clean

######

CHAP_HORDFUN:: ; \
  make -C CHAP_HORDFUN -f ../Makefile.chap main.db
CHAP_HORDFUN:: ; \
  make -C CHAP_HORDFUN -f ../Makefile.chap clean

######

CHAP_REFERENCE:: ; \
  make -C CHAP_REFERENCE -f ../Makefile.chap main.db
CHAP_REFERENCE:: ; \
  make -C CHAP_REFERENCE -f ../Makefile.chap clean

CHAP_ARRAYREF:: ; \
  make -C CHAP_ARRAYREF -f ../Makefile.chap main.db
CHAP_ARRAYREF:: ; \
  make -C CHAP_ARRAYREF -f ../Makefile.chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

upload_html:: ; \
  scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL
uploadloc_html:: ; \
  $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS2TUTORIAL

######

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
cleanall:: ; $(RMF) CODE/chap_*.dats

###### end of [Makefile] ######
