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
# in ats2tutorial.hats before atext2db conversion
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

main.db:: allchap
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
allchap:: \
CHAP_SYNCLR
CHAP_SYNCLR:: ; \
  $(MAKE) -C CHAP_SYNCLR -f ../Makefile_chap main.db
#
clean:: ; $(MAKE) -C CHAP_SYNCLR -f ../Makefile_chap clean
#
######
#
allchap:: \
CHAP_FILENAME
#
CHAP_FILENAME:: ; \
  $(MAKE) -C CHAP_FILENAME -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FILENAME -f ../Makefile_chap clean

allchap:: \
CHAP_FILEINCL
CHAP_FILEINCL:: ; \
  $(MAKE) -C CHAP_FILEINCL -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_FILEINCL -f ../Makefile_chap clean

######

allchap:: \
CHAP_FIXITY
CHAP_FIXITY:: ; \
  $(MAKE) -C CHAP_FIXITY -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_FIXITY -f ../Makefile_chap clean

######

allchap:: \
CHAP_STALOAD
CHAP_STALOAD:: ; \
  $(MAKE) -C CHAP_STALOAD -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_STALOAD -f ../Makefile_chap clean

######

allchap:: \
CHAP_DYNLOAD
CHAP_DYNLOAD:: ; \
  $(MAKE) -C CHAP_DYNLOAD -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_DYNLOAD -f ../Makefile_chap clean

######

allchap:: \
CHAP_DOTOVERLD
CHAP_DOTOVERLD:: ; \
  $(MAKE) -C CHAP_DOTOVERLD -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_DOTOVERLD -f ../Makefile_chap clean

######

allchap:: \
CHAP_BRKTOVERLD
CHAP_BRKTOVERLD:: ; \
  $(MAKE) -C CHAP_BRKTOVERLD -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_BRKTOVERLD -f ../Makefile_chap clean

######

allchap:: \
CHAP_RECURSION
CHAP_RECURSION:: ; \
  $(MAKE) -C CHAP_RECURSION -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_RECURSION -f ../Makefile_chap clean

######

allchap:: \
CHAP_DATATYPES
CHAP_DATATYPES:: ; \
  $(MAKE) -C CHAP_DATATYPES -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_DATATYPES -f ../Makefile_chap clean

######
#
allchap:: \
CHAP_LIST
CHAP_LIST:: ; \
  $(MAKE) -C CHAP_LIST -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_LIST -f ../Makefile_chap clean
#
allchap:: \
CHAP_LIST_VT
CHAP_LIST_VT:: ; \
  $(MAKE) -C CHAP_LIST_VT -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_LIST_VT -f ../Makefile_chap clean
#
######

allchap:: \
CHAP_FUNSETMAP
CHAP_FUNSETMAP:: ; \
  $(MAKE) -C CHAP_FUNSETMAP -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_FUNSETMAP -f ../Makefile_chap clean

######

allchap:: \
CHAP_EXCEPTION
CHAP_EXCEPTION:: ; \
  $(MAKE) -C CHAP_EXCEPTION -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_EXCEPTION -f ../Makefile_chap clean

######

allchap:: \
CHAP_REFERENCE
CHAP_REFERENCE:: ; \
  $(MAKE) -C CHAP_REFERENCE -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_REFERENCE -f ../Makefile_chap clean

######
#
allchap:: \
CHAP_TUPREC_1
CHAP_TUPREC_1:: ; \
  $(MAKE) -C CHAP_TUPREC_1 -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_TUPREC_1 -f ../Makefile_chap clean
#
######
allchap:: \
CHAP_ARRAYREF
CHAP_ARRAYREF:: ; \
  $(MAKE) -C CHAP_ARRAYREF -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_ARRAYREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_ARRSZREF
CHAP_ARRSZREF:: ; \
  $(MAKE) -C CHAP_ARRSZREF -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_ARRSZREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_MATRIXREF
CHAP_MATRIXREF:: ; \
  $(MAKE) -C CHAP_MATRIXREF -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_MATRIXREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_MTRXSZREF
CHAP_MTRXSZREF:: ; \
  $(MAKE) -C CHAP_MTRXSZREF -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_MTRXSZREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_HASHTABLE
CHAP_HASHTABLE:: ; \
  $(MAKE) -C CHAP_HASHTABLE -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_HASHTABLE -f ../Makefile_chap clean

######

allchap:: \
CHAP_TAILREC
CHAP_TAILREC:: ; \
  $(MAKE) -C CHAP_TAILREC -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_TAILREC -f ../Makefile_chap clean

######

allchap:: \
CHAP_HORDFUN
CHAP_HORDFUN:: ; \
  $(MAKE) -C CHAP_HORDFUN -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_HORDFUN -f ../Makefile_chap clean

######

allchap:: \
CHAP_STREAM
CHAP_STREAM:: ; \
  $(MAKE) -C CHAP_STREAM -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_STREAM -f ../Makefile_chap clean

######
#
# Advanced Topics
#
######

allchap:: \
CHAP_EXTVAR
CHAP_EXTVAR:: ; \
  $(MAKE) -C CHAP_EXTVAR -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_EXTVAR -f ../Makefile_chap clean

######

allchap:: \
CHAP_CLOPTR
CHAP_CLOPTR:: ; \
  $(MAKE) -C CHAP_CLOPTR -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_CLOPTR -f ../Makefile_chap clean

######

allchap:: \
CHAP_STKCLO
CHAP_STKCLO:: ; \
  $(MAKE) -C CHAP_STKCLO -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_STKCLO -f ../Makefile_chap clean

######

allchap:: \
CHAP_CODEGEN2
CHAP_CODEGEN2:: ; \
  $(MAKE) -C CHAP_CODEGEN2 -f ../Makefile_chap main.db
clean:: ; $(MAKE) -C CHAP_CODEGEN2 -f ../Makefile_chap clean

######
#
allchap:: \
CHAP_STREAM_VT
CHAP_STREAM_VT:: ; \
  $(MAKE) -C CHAP_STREAM_VT -f ../Makefile_chap main.db
#
clean:: ; $(MAKE) -C CHAP_STREAM_VT -f ../Makefile_chap clean
#
######
#
CPRF=cp -rf
SCPR=scp -r
#
CHMOD=chmod
RSYNC=rsync
#
######

regress:: ; \
  $(MAKE) -C CODE regress

######

upload:: upload_html

upload_pdf:: ; \
  $(SCPR) PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL/
upload_html:: ; \
  $(RSYNC) -av --delete HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL

######

uploadloc:: ; $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS2TUTORIAL

######
#
upload_code:: ; \
  $(MAKE) -C CODE cleanall
upload_code:: ; \
  $(RSYNC) -av --delete CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *_atxt_dats.c
clean:: ; $(RMF) HTML/htmltoc_dats.c
clean:: ; $(MAKE) -C HTML clean
clean:: ; $(MAKE) -C MYTEXT clean

cleanall:: clean
cleanall:: ; $(RMF) preface
cleanall:: ; $(RMF) preface.db
cleanall:: ; $(RMF) PDF/main.pdf
cleanall:: ; $(RMF) TEMP/chap_*.dats
cleanall:: ; $(RMF) HTML/htmltoc.exe
cleanall:: ; $(MAKE) -C HTML cleanall
cleanall:: ; $(MAKE) -C MYTEXT cleanall

###### end of [Makefile] ######
