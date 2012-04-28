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

all:: unistd.sats
unistd.sats: unistd_atxt.exe ; ./$< > $@
unistd_atxt.exe: unistd_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ unistd_atxt.dats -latsdoc
unistd_atxt.dats: unistd.atxt
	$(ATSDOC) -do $@ -i unistd.atxt > unistd_atxt.txt
clean:: ; $(RMF) unistd_atxt.exe
cleanall:: ; $(RMF) unistd.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
