#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######
#
GCFLAG=
#
# GCFLAG=-D_ATS_GCATS
#
######

all::

######

all:: giterator.sats
giterator.sats: giterator_atxt.exe ; ./$< > $@
giterator_atxt.exe: giterator_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ giterator_atxt.dats -latsdoc
giterator_atxt.dats: giterator.atxt
	$(ATSDOC) --outcode $@ -i giterator.atxt > giterator_atxt.txt
clean:: ; $(RMF) giterator_atxt.exe
cleanall:: ; $(RMF) giterator.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
