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

all:: strobjref.sats
strobjref.sats: strobjref_atxt.exe ; ./$< > $@
strobjref_atxt.exe: strobjref_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ strobjref_atxt.dats -latsdoc
strobjref_atxt.dats: strobjref.atxt
	$(ATSDOC) -do $@ -i strobjref.atxt > strobjref_atxt.txt
clean:: ; $(RMF) strobjref_atxt.exe
cleanall:: ; $(RMF) strobjref.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
