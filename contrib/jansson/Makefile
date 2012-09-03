#
# API for cairo in ATS
#
# Start Time: August, 2012
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSCTRB="$(PATSHOME)"/contrib
JANSSONCLFLAGS=-ljansson

######

all::

######

all:: atsctrb_jansson.o
atsctrb_jansson.o: jansson_dats.o ; ld -r -o $@ $^

######

jansson_dats.o: DATS/jansson.dats
	$(ATSCC) -O2 -I$(ATSCTRB) -IATS$(ATSCTRB) -o $@ -c $< $(JANSSONCLFLAGS)

######

RMF=rm -f

######

all:: clean
clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) atsctrb_jansson.o

###### end of [Makefile] ######
