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
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"

######

INCLATS:=-IATS $(ATSHOMEQ)

######

ATSGCFLAG=-D_ATS_GCATS

######

CAT=cat

######

all::
all_html::
all_script::

######

all_html:: HTML/patsopt.html
HTML/patsopt.html: patsopt_atxt.exe ; ./$< > $@
all_script:: SCRIPT/patsopt.bash
SCRIPT/patsopt.bash: patsopt_atxt.exe ; ./$< > $@
patsopt_atxt.dats: patsopt.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __datatok --outcode $@ > /dev/null
patsopt_atxt.exe: patsopt_atxt.dats ; $(ATSCC) $(INCLATS) $(ATSGCFLAG) -o $@ $< -latsdoc
clean:: ; $(RMF) patsopt_atxt.exe
cleanall:: ; $(RMF) HTML/patsopt.html
cleanall:: ; $(RMF) SCRIPT/patsopt.bash


######

srcgetall: SCRIPT/patsopt.bash ; bash $<

######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/PACKAGE/patsopt

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
