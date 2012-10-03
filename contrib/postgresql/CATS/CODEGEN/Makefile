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

all:: libpq-fe.cats
libpq-fe.cats: libpq-fe_atxt.exe ; ./$< > $@
libpq-fe_atxt.exe: libpq-fe_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ libpq-fe_atxt.dats -latsdoc
libpq-fe_atxt.dats: libpq-fe.atxt
	$(ATSDOC) --outcode $@ -i libpq-fe.atxt > libpq-fe_atxt.txt
clean:: ; $(RMF) libpq-fe_atxt.exe
cleanall:: ; $(RMF) libpq-fe.cats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
