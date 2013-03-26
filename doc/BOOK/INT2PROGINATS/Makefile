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

allchap:: CHAP_START
allchap:: CHAP_PROGELEM
allchap:: CHAP_FUNCTION

######

CHAP_START:: ; \
  make -C CHAP_START -f ../Makefile.chap main.db
CHAP_START:: ; \
  make -C CHAP_START -f ../Makefile.chap clean

CHAP_PROGELEM:: ; \
  make -C CHAP_PROGELEM -f ../Makefile.chap main.db
CHAP_PROGELEM:: ; \
  make -C CHAP_PROGELEM -f ../Makefile.chap clean

CHAP_FUNCTION:: ; \
  make -C CHAP_FUNCTION -f ../Makefile.chap main.db
CHAP_FUNCTION:: ; \
  make -C CHAP_FUNCTION -f ../Makefile.chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

upload:: ; \
  scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS
uploadloc:: ; \
  $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/INT2PROGINATS

upload_pdf:: ; \
  scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS/

######

upload_code:: ; \
  scp -r CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS

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
