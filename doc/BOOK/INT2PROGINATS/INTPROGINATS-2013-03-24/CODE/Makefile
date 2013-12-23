#
# A simple Makefile
#

######

checkall::
checkall:: ; make -C CHAPTER_START checkall
checkall:: ; make -C CHAPTER_FUNCTIONS checkall
checkall:: ; make -C CHAPTER_DATATYPES checkall
checkall:: ; make -C CHAPTER_EFFECTFUL checkall
checkall:: ; make -C CHAPTER_POLYMORPHISM checkall
checkall:: ; make -C CHAPTER_MODULARITY checkall
checkall:: ; make -C CHAPTER_DEPTYPES checkall
checkall:: ; make -C CHAPTER_DEPREFDTS checkall
checkall:: ; make -C CHAPTER_THMPRVING checkall
checkall:: ; make -C CHAPTER_PwTP checkall
checkall:: ; make -C CHAPTER_VVTINTRO checkall
checkall:: ; make -C CHAPTER_DATAVIEWS checkall
checkall:: ; make -C CHAPTER_DATAVTYPES checkall
checkall:: ; make -C CHAPTER_ABSVTYPES checkall

######

cleanall:: ; rm -f *~
cleanall:: ; make -C CHAPTER_START cleanall
cleanall:: ; make -C CHAPTER_FUNCTIONS cleanall
cleanall:: ; make -C CHAPTER_DATATYPES cleanall
cleanall:: ; make -C CHAPTER_EFFECTFUL cleanall
cleanall:: ; make -C CHAPTER_POLYMORPHISM cleanall
cleanall:: ; make -C CHAPTER_MODULARITY cleanall
cleanall:: ; make -C CHAPTER_DEPTYPES cleanall
cleanall:: ; make -C CHAPTER_DEPREFDTS cleanall
cleanall:: ; make -C CHAPTER_THMPRVING cleanall
cleanall:: ; make -C CHAPTER_PwTP cleanall
cleanall:: ; make -C CHAPTER_VVTINTRO cleanall
cleanall:: ; make -C CHAPTER_DATAVIEWS cleanall
cleanall:: ; make -C CHAPTER_DATAVTYPES cleanall
cleanall:: ; make -C CHAPTER_ABSVTYPES cleanall

distclean:: cleanall

######

upload:: START
upload:: FUNCTIONS
upload:: DATATYPES
upload:: POLYMORPHISM
upload:: EFFECTFUL
upload:: MODULARITY
upload:: DEPTYPES
upload:: DEPREFDTS
upload:: THMPRVING
upload:: PwTP
upload:: VVTINTRO
upload:: DATAVIEWS
upload:: DATAVTYPES
upload:: ABSVTYPES

######

START:
	scp -r CHAPTER_START ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

FUNCTIONS:
	scp -r CHAPTER_FUNCTIONS ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

DATATYPES:
	scp -r CHAPTER_DATATYPES ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

POLYMORPHISM:
	scp -r CHAPTER_POLYMORPHISM ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

EFFECTFUL:
	scp -r CHAPTER_EFFECTFUL ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

MODULARITY:
	scp -r CHAPTER_MODULARITY ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

DEPTYPES:
	scp -r CHAPTER_DEPTYPES ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

DEPREFDTS:
	scp -r CHAPTER_DEPREFDTS ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

THMPRVING:
	scp -r CHAPTER_THMPRVING ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

PwTP:
	scp -r CHAPTER_PwTP ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

VVTINTRO:
	scp -r CHAPTER_VVTINTRO ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

DATAVIEWS:
	scp -r CHAPTER_DATAVIEWS ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

DATAVTYPES:
	scp -r CHAPTER_DATAVTYPES ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

ABSVTYPES:
	scp -r CHAPTER_ABSVTYPES ats-hwxi,ats-lang@web.sourceforge.net:htdocs/DOCUMENT/INTPROGINATS/CODE

###### end of [Makefile]
