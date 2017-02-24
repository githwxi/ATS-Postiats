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

all:: cairo.cats
cairo.cats: cairo_atxt.exe ; ./$< > $@
cairo_atxt.exe: cairo_atxt.dats
	$(ATSCC) -D_ATS_GCATS -o $@ cairo_atxt.dats -latsdoc
cairo_atxt.dats: cairo.atxt
	$(ATSDOC) --outcode $@ -i cairo.atxt > cairo_atxt.txt
clean:: ; $(RMF) cairo_atxt.exe
cleanall:: ; $(RMF) cairo.cats

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
