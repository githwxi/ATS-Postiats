#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

all:: test01
all:: test02

######

test01: test01.dats
	$(ATSCC) -I$(PATSHOME)/src -IATS $(PATSHOME) -o $@ $< -L $(PATSHOME)/libatsynmark -latsynmark
cleanall:: ; $(RMF) test01

test02: test02.dats
	$(ATSCC) -I$(PATSHOME)/src -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< -L $(PATSHOME)/libatsynmark -latsynmark
cleanall:: ; $(RMF) test02

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

