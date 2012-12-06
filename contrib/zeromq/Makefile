#
# API for zeromq in ATS
#
# Start Time: December, 2012
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSCTRB="$(PATSHOME)"/contrib
ZMQCLFLAGS=-lzmq

######

all::

######

all:: atsctrb_zeromq.o
atsctrb_zeromq.o: zeromq_dats.o ; ld -r -o $@ $^

######

zeromq_dats.o: DATS/zeromq.dats
	$(ATSCC) -O2 -I$(ATSCTRB) -IATS$(ATSCTRB) -o $@ -c $< $(ZMQCLFLAGS)

######

RMF=rm -f

######

all:: clean
clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) atsctrb_zeromq.o

###### end of [Makefile] ######
