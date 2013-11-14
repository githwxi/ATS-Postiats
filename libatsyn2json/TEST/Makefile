#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

all:: mytest

######

mytest: mytest.dats
	$(ATSCC) -I$(PATSHOME)/src -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< -L $(PATSHOME)/libatsyn2json -latsyn2json -lgmp
cleanall:: ; $(RMF) mytest

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

