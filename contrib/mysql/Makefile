#
# API for mysql in ATS2
#
# Start Time: August, 2012
# Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSCTRB="$(PATSHOME)"/contrib
MYSQLCLFLAGS=`mysql_config --cflags --libs`

######

all::

######

all:: atsctrb_mysql.o
atsctrb_mysql.o: mysql_dats.o ; ld -r -o $@ $^

######

mysql_dats.o: DATS/mysql.dats
	$(PATSCC) -O2 -IIATS $(PATSCTRB) -o $@ -c $< $(MYSQLCLFLAGS)

######

RMF=rm -f

######

all:: clean
clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) atsctrb_mysql.o

###### end of [Makefile] ######
