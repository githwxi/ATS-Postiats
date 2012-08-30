#
#
# A simple Makefile
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

all::

######

all:: mysql.cats
mysql.cats: mysql_atxt.exe ; ./$< > $@
mysql_atxt.exe: mysql_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ mysql_atxt.dats -latsdoc
mysql_atxt.dats: mysql.atxt
	$(ATSDOC) --outcode $@ -i mysql.atxt > mysql_atxt.txt
clean:: ; $(RMF) mysql_atxt.exe
cleanall:: ; $(RMF) mysql.cats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
