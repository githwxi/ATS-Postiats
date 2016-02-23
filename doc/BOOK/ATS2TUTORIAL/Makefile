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
all:: htmltoc

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
htmltoc: ; $(MAKE) -C HTML -f Makefile htmltoc
#
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
#
# Basic Topics
#
######

allchap:: \
CHAP_SYNCLR
CHAP_SYNCLR:: ; \
  make -C CHAP_SYNCLR -f ../Makefile_chap main.db
clean:: ; make -C CHAP_SYNCLR -f ../Makefile_chap clean

######

allchap:: \
CHAP_FILENAME
CHAP_FILENAME:: ; \
  make -C CHAP_FILENAME -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FILENAME -f ../Makefile_chap clean

allchap:: \
CHAP_FILEINCL
CHAP_FILEINCL:: ; \
  make -C CHAP_FILEINCL -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FILEINCL -f ../Makefile_chap clean

######

allchap:: \
CHAP_FIXITY
CHAP_FIXITY:: ; \
  make -C CHAP_FIXITY -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FIXITY -f ../Makefile_chap clean

######

allchap:: \
CHAP_STALOAD
CHAP_STALOAD:: ; \
  make -C CHAP_STALOAD -f ../Makefile_chap main.db
clean:: ; make -C CHAP_STALOAD -f ../Makefile_chap clean

######

allchap:: \
CHAP_DYNLOAD
CHAP_DYNLOAD:: ; \
  make -C CHAP_DYNLOAD -f ../Makefile_chap main.db
clean:: ; make -C CHAP_DYNLOAD -f ../Makefile_chap clean

######

allchap:: \
CHAP_DOTOVERLD
CHAP_DOTOVERLD:: ; \
  make -C CHAP_DOTOVERLD -f ../Makefile_chap main.db
clean:: ; make -C CHAP_DOTOVERLD -f ../Makefile_chap clean

######

allchap:: \
CHAP_BRKTOVERLD
CHAP_BRKTOVERLD:: ; \
  make -C CHAP_BRKTOVERLD -f ../Makefile_chap main.db
clean:: ; make -C CHAP_BRKTOVERLD -f ../Makefile_chap clean

######

allchap:: \
CHAP_RECURSION
CHAP_RECURSION:: ; \
  make -C CHAP_RECURSION -f ../Makefile_chap main.db
clean:: ; make -C CHAP_RECURSION -f ../Makefile_chap clean

######

allchap:: \
CHAP_DATATYPES
CHAP_DATATYPES:: ; \
  make -C CHAP_DATATYPES -f ../Makefile_chap main.db
clean:: ; make -C CHAP_DATATYPES -f ../Makefile_chap clean

######
#
allchap:: \
CHAP_LIST
CHAP_LIST:: ; \
  make -C CHAP_LIST -f ../Makefile_chap main.db
clean:: ; make -C CHAP_LIST -f ../Makefile_chap clean
#
allchap:: \
CHAP_LIST_VT
CHAP_LIST_VT:: ; \
  make -C CHAP_LIST_VT -f ../Makefile_chap main.db
clean:: ; make -C CHAP_LIST_VT -f ../Makefile_chap clean
#
######

allchap:: \
CHAP_FUNSETMAP
CHAP_FUNSETMAP:: ; \
  make -C CHAP_FUNSETMAP -f ../Makefile_chap main.db
clean:: ; make -C CHAP_FUNSETMAP -f ../Makefile_chap clean

######

allchap:: \
CHAP_EXCEPTION
CHAP_EXCEPTION:: ; \
  make -C CHAP_EXCEPTION -f ../Makefile_chap main.db
clean:: ; make -C CHAP_EXCEPTION -f ../Makefile_chap clean

######

allchap:: \
CHAP_REFERENCE
CHAP_REFERENCE:: ; \
  make -C CHAP_REFERENCE -f ../Makefile_chap main.db
clean:: ; make -C CHAP_REFERENCE -f ../Makefile_chap clean

######
#
allchap:: \
CHAP_TUPREC_1
CHAP_TUPREC_1:: ; \
  make -C CHAP_TUPREC_1 -f ../Makefile_chap main.db
clean:: ; make -C CHAP_TUPREC_1 -f ../Makefile_chap clean
#
######
allchap:: \
CHAP_ARRAYREF
CHAP_ARRAYREF:: ; \
  make -C CHAP_ARRAYREF -f ../Makefile_chap main.db
clean:: ; make -C CHAP_ARRAYREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_ARRSZREF
CHAP_ARRSZREF:: ; \
  make -C CHAP_ARRSZREF -f ../Makefile_chap main.db
clean:: ; make -C CHAP_ARRSZREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_MATRIXREF
CHAP_MATRIXREF:: ; \
  make -C CHAP_MATRIXREF -f ../Makefile_chap main.db
clean:: ; make -C CHAP_MATRIXREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_MTRXSZREF
CHAP_MTRXSZREF:: ; \
  make -C CHAP_MTRXSZREF -f ../Makefile_chap main.db
clean:: ; make -C CHAP_MTRXSZREF -f ../Makefile_chap clean

######

allchap:: \
CHAP_HASHTABLE
CHAP_HASHTABLE:: ; \
  make -C CHAP_HASHTABLE -f ../Makefile_chap main.db
clean:: ; make -C CHAP_HASHTABLE -f ../Makefile_chap clean

######

allchap:: \
CHAP_TAILREC
CHAP_TAILREC:: ; \
  make -C CHAP_TAILREC -f ../Makefile_chap main.db
clean:: ; make -C CHAP_TAILREC -f ../Makefile_chap clean

######

allchap:: \
CHAP_HORDFUN
CHAP_HORDFUN:: ; \
  make -C CHAP_HORDFUN -f ../Makefile_chap main.db
clean:: ; make -C CHAP_HORDFUN -f ../Makefile_chap clean

######

allchap:: \
CHAP_STREAM
CHAP_STREAM:: ; \
  make -C CHAP_STREAM -f ../Makefile_chap main.db
clean:: ; make -C CHAP_STREAM -f ../Makefile_chap clean

######
#
# Advanced Topics
#
######

allchap:: \
CHAP_EXTVAR
CHAP_EXTVAR:: ; \
  make -C CHAP_EXTVAR -f ../Makefile_chap main.db
clean:: ; make -C CHAP_EXTVAR -f ../Makefile_chap clean

######

allchap:: \
CHAP_CLOPTR
CHAP_CLOPTR:: ; \
  make -C CHAP_CLOPTR -f ../Makefile_chap main.db
clean:: ; make -C CHAP_CLOPTR -f ../Makefile_chap clean

######

allchap:: \
CHAP_STKCLO
CHAP_STKCLO:: ; \
  make -C CHAP_STKCLO -f ../Makefile_chap main.db
clean:: ; make -C CHAP_STKCLO -f ../Makefile_chap clean

######

allchap:: \
CHAP_CODEGEN2
CHAP_CODEGEN2:: ; \
  make -C CHAP_CODEGEN2 -f ../Makefile_chap main.db
clean:: ; make -C CHAP_CODEGEN2 -f ../Makefile_chap clean

######

allchap:: \
CHAP_STREAM_VT
CHAP_STREAM_VT:: ; \
  make -C CHAP_STREAM_VT -f ../Makefile_chap main.db
clean:: ; make -C CHAP_STREAM_VT -f ../Makefile_chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

regress:: ; \
  $(MAKE) -C CODE regress

######

upload:: upload_html

upload_pdf:: ; \
  scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL/
upload_html:: ; \
  rsync -av --delete HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL

######

uploadloc:: ; $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/ATS2TUTORIAL

######
#
upload_code:: ; \
  make -C CODE cleanall
upload_code:: ; \
  rsync -av --delete CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/ATS2TUTORIAL
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) *_atxt_dats.c
clean:: ; $(RMF) HTML/htmltoc_dats.c

cleanall:: clean
cleanall:: ; $(RMF) preface
cleanall:: ; $(RMF) preface.db
cleanall:: ; $(RMF) PDF/main.pdf
cleanall:: ; $(RMF) TEMP/chap_*.dats
cleanall:: ; $(RMF) HTML/htmltoc.exe

###### end of [Makefile] ######
