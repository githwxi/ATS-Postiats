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

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

all:: unistd.sats
unistd.sats: unistd_atxt.exe ; ./$< > $@
unistd_atxt.exe: unistd_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ unistd_atxt.dats -latsdoc
unistd_atxt.dats: unistd.atxt
	$(ATSDOC) --outcode $@ -i unistd.atxt > unistd_atxt.txt
clean:: ; $(RMF) unistd_atxt.exe
cleanall:: ; $(RMF) unistd.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
