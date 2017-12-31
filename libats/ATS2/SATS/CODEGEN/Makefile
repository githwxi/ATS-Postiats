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

all:: fcntainer.sats
fcntainer.sats: fcntainer_atxt.exe ; ./$< > $@
fcntainer_atxt.exe: fcntainer_atxt.dats
	$(ATSCC) $(GCFLAG) -o $@ fcntainer_atxt.dats -latsdoc
fcntainer_atxt.dats: fcntainer.atxt
	$(ATSDOC) --outcode $@ -i fcntainer.atxt > fcntainer_atxt.txt
clean:: ; $(RMF) fcntainer_atxt.exe
cleanall:: ; $(RMF) fcntainer.sats

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
