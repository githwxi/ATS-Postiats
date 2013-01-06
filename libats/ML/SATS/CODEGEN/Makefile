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

all::

######

all:: list0.sats
list0.sats: list0_atxt.exe ; ./$< > $@
list0_atxt.exe: list0_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ list0_atxt.dats -latsdoc
list0_atxt.dats: list0.atxt
	$(ATSDOC) --outcode $@ -i list0.atxt > list0_atxt.txt
clean:: ; $(RMF) list0_atxt.exe
cleanall:: ; $(RMF) list0.sats

all:: option0.sats
option0.sats: option0_atxt.exe ; ./$< > $@
option0_atxt.exe: option0_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ option0_atxt.dats -latsdoc
option0_atxt.dats: option0.atxt
	$(ATSDOC) --outcode $@ -i option0.atxt > option0_atxt.txt
clean:: ; $(RMF) option0_atxt.exe
cleanall:: ; $(RMF) option0.sats

all:: array0.sats
array0.sats: array0_atxt.exe ; ./$< > $@
array0_atxt.exe: array0_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ array0_atxt.dats -latsdoc
array0_atxt.dats: array0.atxt
	$(ATSDOC) --outcode $@ -i array0.atxt > array0_atxt.txt
clean:: ; $(RMF) array0_atxt.exe
cleanall:: ; $(RMF) array0.sats

all:: string.sats
string.sats: string_atxt.exe ; ./$< > $@
string_atxt.exe: string_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ string_atxt.dats -latsdoc
string_atxt.dats: string.atxt
	$(ATSDOC) --outcode $@ -i string.atxt > string_atxt.txt
clean:: ; $(RMF) string_atxt.exe
cleanall:: ; $(RMF) string.sats


all:: filebas.sats
filebas.sats: filebas_atxt.exe ; ./$< > $@
filebas_atxt.exe: filebas_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ filebas_atxt.dats -latsdoc
filebas_atxt.dats: filebas.atxt
	$(ATSDOC) --outcode $@ -i filebas.atxt > filebas_atxt.txt
clean:: ; $(RMF) filebas_atxt.exe
cleanall:: ; $(RMF) filebas.sats


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
