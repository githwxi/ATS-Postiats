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
#
# PART I
#
allchap:: CHAP_START
allchap:: CHAP_PROGELEM
allchap:: CHAP_FUNCTION
allchap:: CHAP_DATATYPE
allchap:: CHAP_POLYMORPH
#
######
#
# PART II
#
allchap:: CHAP_EFFECTFUL
allchap:: CHAP_MODULARITY
allchap:: CHAP_CINTERACT
#
######
#
# PART III
#
allchap:: CHAP_DEPTYPES
allchap:: CHAP_DEPDTREF
allchap:: CHAP_THMPRVING
allchap:: CHAP_PRGTHMPRV
#
######
#
# PART IV
#
allchap:: CHAP_VVTINTRO
allchap:: CHAP_DATAVIEW
allchap:: CHAP_DATAVTYPE
allchap:: CHAP_ABSVTYPE
#
######

CHAP_START:: ; \
  make -C CHAP_START -f ../Makefile.chap main.db
clean:: ; make -C CHAP_START -f ../Makefile.chap clean

CHAP_PROGELEM:: ; \
  make -C CHAP_PROGELEM -f ../Makefile.chap main.db
clean:: ; make -C CHAP_PROGELEM -f ../Makefile.chap clean

CHAP_FUNCTION:: ; \
  make -C CHAP_FUNCTION -f ../Makefile.chap main.db
clean:: ; make -C CHAP_FUNCTION -f ../Makefile.chap clean

CHAP_DATATYPE:: ; \
  make -C CHAP_DATATYPE -f ../Makefile.chap main.db
clean:: ; make -C CHAP_DATATYPE -f ../Makefile.chap clean

CHAP_POLYMORPH:: ; \
  make -C CHAP_POLYMORPH -f ../Makefile.chap main.db
clean:: ; make -C CHAP_POLYMORPH -f ../Makefile.chap clean

######

CHAP_EFFECTFUL:: ; \
  make -C CHAP_EFFECTFUL -f ../Makefile.chap main.db
clean:: ; make -C CHAP_EFFECTFUL -f ../Makefile.chap clean

######

CHAP_MODULARITY:: ; \
  make -C CHAP_MODULARITY -f ../Makefile.chap main.db
clean:: ; make -C CHAP_MODULARITY -f ../Makefile.chap clean

######

CHAP_CINTERACT:: ; \
  make -C CHAP_CINTERACT -f ../Makefile.chap main.db
clean:: ; make -C CHAP_CINTERACT -f ../Makefile.chap clean

######

CHAP_DEPTYPES:: ; \
  make -C CHAP_DEPTYPES -f ../Makefile.chap main.db
clean:: ; make -C CHAP_DEPTYPES -f ../Makefile.chap clean

######

CHAP_DEPDTREF:: ; \
  make -C CHAP_DEPDTREF -f ../Makefile.chap main.db
clean:: ; make -C CHAP_DEPDTREF -f ../Makefile.chap clean

######

CHAP_THMPRVING:: ; \
  make -C CHAP_THMPRVING -f ../Makefile.chap main.db
clean:: ; make -C CHAP_THMPRVING -f ../Makefile.chap clean

######

CHAP_PRGTHMPRV:: ; \
  make -C CHAP_PRGTHMPRV -f ../Makefile.chap main.db
clean:: ; make -C CHAP_PRGTHMPRV -f ../Makefile.chap clean

######

CHAP_VVTINTRO:: ; \
  make -C CHAP_VVTINTRO -f ../Makefile.chap main.db
clean:: ; make -C CHAP_VVTINTRO -f ../Makefile.chap clean

######

CHAP_DATAVIEW:: ; \
  make -C CHAP_DATAVIEW -f ../Makefile.chap main.db
clean:: ; make -C CHAP_DATAVIEW -f ../Makefile.chap clean

######

CHAP_DATAVTYPE:: ; \
  make -C CHAP_DATAVTYPE -f ../Makefile.chap main.db
clean:: ; make -C CHAP_DATAVTYPE -f ../Makefile.chap clean

######

CHAP_ABSVTYPE:: ; \
  make -C CHAP_ABSVTYPE -f ../Makefile.chap main.db
clean:: ; make -C CHAP_ABSVTYPE -f ../Makefile.chap clean

######

CPRF=cp -rf
SCPR=scp -r
CHMOD=chmod

######

upload:: upload_html

upload_pdf:: ; \
  scp -r PDF ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS/
upload_html:: ; \
  scp -r HTML ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS

######

uploadloc:: ; \
  $(SCPR) PDF hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/INT2PROGINATS
  $(SCPR) HTML hwxi@csa2.bu.edu:public_html/ATS/DOCUMENT/INT2PROGINATS

######
#
upload_code:: ; \
  make -C CODE cleanall
upload_code:: ; \
  scp -r CODE ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INT2PROGINATS
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

###### end of [Makefile] ######
