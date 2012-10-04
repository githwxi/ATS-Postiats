#
# API for postgresql in ATS
#
# Start Time: August, 2012
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
#

######

ATSHOMEQ="$(ATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSCTRB="$(PATSHOME)"/contrib
PGCLFLAGSLAGS=`pg_config --cflags --libs`

######

all::

######

all:: atsctrb_postgresql.o
atsctrb_postgresql.o: postgresql_dats.o ; ld -r -o $@ $^

######

postgresql_dats.o: DATS/postgresql.dats
	$(ATSCC) -O2 -I$(ATSCTRB) -IATS$(ATSCTRB) -o $@ -c $< $(PGCLFLAGS)

######

RMF=rm -f

######

all:: clean
clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) atsctrb_postgresql.o

###### end of [Makefile] ######
