#
# A simple Makefile
#

######

ATSCC=$(ATSHOME)/bin/atscc
CCFLAGS=-O2
MYSQLCFLAGS=`mysql_config --cflags --libs`

######

ATSCTRB=$(ATSHOME)/contrib

######

all::
all:: test01
all:: test02
all:: test03
all:: test04
all:: test05
all:: test06

######

clean::
cleanall::

######

test01: test01_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test01 $< $(MYSQLCFLAGS)
cleanall:: ; $(RMF) test01

######

test02: test02_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test02 $< $(MYSQLCFLAGS) $(ATSCTRB)/mysql/atsctrb_mysql.o
cleanall:: ; $(RMF) test02

######

test03: test03_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test03 $< $(MYSQLCFLAGS) $(ATSCTRB)/mysql/atsctrb_mysql.o
cleanall:: ; $(RMF) test03

######

test04: test04_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test04 $< $(MYSQLCFLAGS) $(ATSCTRB)/mysql/atsctrb_mysql.o
cleanall:: ; $(RMF) test04

######

test05: test05_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test05 $< $(MYSQLCFLAGS) $(ATSCTRB)/mysql/atsctrb_mysql.o
cleanall:: ; $(RMF) test05

######

test06: test06_dats.c
	$(ATSCC) $(CCFLAGS) -I$(ATSCTRB) -o test06 $< $(MYSQLCFLAGS) $(ATSCTRB)/mysql/atsctrb_mysql.o
cleanall:: ; $(RMF) test06

######

%_dats.c: %.dats ; $(ATSCC) -cc -IATS$(ATSCTRB) $<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c

######

cleanall:: clean

###### end of [Makefile] ######
