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

all:: jansson.cats
jansson.cats: jansson_atxt.exe ; ./$< > $@
jansson_atxt.exe: jansson_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ jansson_atxt.dats -latsdoc
jansson_atxt.dats: jansson.atxt
	$(ATSDOC) --outcode $@ -i jansson.atxt > jansson_atxt.txt
clean:: ; $(RMF) jansson_atxt.exe
cleanall:: ; $(RMF) jansson.cats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
