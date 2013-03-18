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

all:: types.cats
types.cats: types_atxt.exe ; ./$< > $@
types_atxt.exe: types_atxt.dats
	$(ATSCC) $(ATSGCFLAG) -o $@ types_atxt.dats -latsdoc
types_atxt.dats: types.atxt
	$(ATSDOC) --outcode $@ -i types.atxt > types_atxt.txt
clean:: ; $(RMF) types_atxt.exe
cleanall:: ; $(RMF) types.cats


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
