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

JADE=/usr/bin/openjade

######

pdf: main.db ; jw -b pdf --dsl default --parser $(JADE) --output PDF/ main.db

######

html: main.db ; jw -b html --dsl default --parser $(JADE) --output HTML/ main.db

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

allchap:: CHAP_FILE_IO
CHAP_FILE_IO:: ; \
  make -C CHAP_FILE_IO -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FILE_IO -f ../Makefile_chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

upload:: upload_html

upload_pdf:: ; \
  scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-for-APUE3/
upload_html:: ; \
  scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-for-APUE3/

######

uploadloc:: ; $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS-for-APUE3/

######
#
upload_code:: ; \
  make -C CODE cleanall
upload_code:: ; \
  scp -r CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS-for-APUE3
#
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
cleanall:: ; $(RMF) TEMP/chap_*.dats

###### end of [Makefile] ######
