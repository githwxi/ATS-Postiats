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
all:: synhilit
all:: htmltoc
all:: clean

######

cleanall::

######

MAKE=make
JADE=/usr/bin/openjade

######
#
DSL=default
DSL=./mydocbook.dsl
#
# HX-2016-08-01:
# PDF needs to be changed from 0 to 1
# in ats2funcrash.hats before atext2db conversion
#
pdf: main.db ; \
jw -b pdf --dsl default --parser $(JADE) --output PDF/ main.db
#
######
#
DSL=default
DSL=./mydocbook.dsl
#
html: main.db ; \
jw -b html --parser $(JADE) --dsl $(DSL) --output HTML/ main.db
#
htmltoc: ; \
$(MAKE) -C HTML -f Makefile htmltoc
#
synhilit: \
mytexting; $(MAKE) -C HTML synhilit
mytexting: ; $(MAKE) -C MYTEXT mytexting
#
######

main.db:: lectures
main.db:: preface.db

######

preface.exe: preface_atxt.dats
	$(ATSCC) -D_ATS_NGC -o $@ preface_atxt.dats -latsdoc
preface_atxt.dats: preface.atxt
	$(ATSDOC) --outcode $@ -i preface.atxt > preface_atxt.txt
preface.db:: preface.exe ; ./$< > $@
preface.db:: ; $(RMF) preface.exe preface_atxt_dats.c preface_atxt.dats preface_atxt.txt

######
#
# Basic Topics
#
######
#
lectures:: lecture01
lectures:: lecture02
lectures:: lecture03
lectures:: lecture03-10
lectures:: lecture04
lectures:: lecture04-10
lectures:: lecture05
lectures:: lecture06
lectures:: lecture06-10
lectures:: lecture06-20
lectures:: lecture07
lectures:: lecture07-10
lectures:: lecture08
lectures:: lecture08-10
lectures:: lecture09
lectures:: lecture10
lectures:: lecture10-10
lectures:: lecture11
lectures:: lecture12
lectures:: lecture12-10
#
######
#
lecture01:: ; \
$(MAKE) -C LECTURE/01 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/01 -f ../Makefile_lect clean
#
lecture02:: ; \
$(MAKE) -C LECTURE/02 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/02 -f ../Makefile_lect clean
#
lecture03:: ; \
$(MAKE) -C LECTURE/03 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/03 -f ../Makefile_lect clean
lecture03-10:: ; \
$(MAKE) -C LECTURE/03-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/03-10 -f ../Makefile_lect clean
#
lecture04:: ; \
$(MAKE) -C LECTURE/04 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/04 -f ../Makefile_lect clean
lecture04-10:: ; \
$(MAKE) -C LECTURE/04-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/04-10 -f ../Makefile_lect clean
#
lecture05:: ; \
$(MAKE) -C LECTURE/05 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/05 -f ../Makefile_lect clean
#
lecture06:: ; \
$(MAKE) -C LECTURE/06 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/06 -f ../Makefile_lect clean
lecture06-10:: ; \
$(MAKE) -C LECTURE/06-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/06-10 -f ../Makefile_lect clean
lecture06-20:: ; \
$(MAKE) -C LECTURE/06-20 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/06-20 -f ../Makefile_lect clean
#
lecture07:: ; \
$(MAKE) -C LECTURE/07 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/07 -f ../Makefile_lect clean
lecture07-10:: ; \
$(MAKE) -C LECTURE/07-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/07-10 -f ../Makefile_lect clean
#
lecture08:: ; \
$(MAKE) -C LECTURE/08 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/08 -f ../Makefile_lect clean
lecture08-10:: ; \
$(MAKE) -C LECTURE/08-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/08-10 -f ../Makefile_lect clean
#
lecture09:: ; \
$(MAKE) -C LECTURE/09 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/09 -f ../Makefile_lect clean
#
lecture10:: ; \
$(MAKE) -C LECTURE/10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/10 -f ../Makefile_lect clean
lecture10-10:: ; \
$(MAKE) -C LECTURE/10-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/10-10 -f ../Makefile_lect clean
#
lecture11:: ; \
$(MAKE) -C LECTURE/11 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/11 -f ../Makefile_lect clean
#
lecture12:: ; \
$(MAKE) -C LECTURE/12 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/12 -f ../Makefile_lect clean
#
lecture12-10:: ; \
$(MAKE) -C LECTURE/12-10 -f ../Makefile_lect main.db
clean:: ; $(MAKE) -C LECTURE/12-10 -f ../Makefile_lect clean
#
######
#
CPRF=cp -rf
SCPR=scp -r
#
RSYNC=rsync
CHMOD=chmod
#
######

testall:: ; \
$(MAKE) -C LECTURE -f Makefile_lect testall

######

upload:: upload_html

upload_pdf:: ; \
  $(SCPR) PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2FUNCRASH/
upload_html:: ; \
  $(RSYNC) -av --delete HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2FUNCRASH

######

uploadloc:: ; $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS2FUNCRASH

######
#
upload_code:: ; \
  $(MAKE) -C CODE cleanall
upload_code:: ; \
  $(RSYNC) -av --delete CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2FUNCRASH
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *_atxt_dats.c
clean:: ; $(RMF) HTML/htmltoc_dats.c
clean:: ; make -C HTML clean
clean:: ; make -C MYTEXT clean

cleanall:: clean
cleanall:: ; $(RMF) preface
cleanall:: ; $(RMF) preface.db
cleanall:: ; $(RMF) PDF/main.pdf
cleanall:: ; $(RMF) HTML/htmltoc.exe
cleanall:: ; make -C HTML cleanall
cleanall:: ; make -C MYTEXT cleanall

###### end of [Makefile] ######
