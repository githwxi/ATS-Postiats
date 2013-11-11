#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

all:: test1
all:: test2

######

test1: test1.dats
	$(ATSCC) -I$(PATSHOME)/src -IATS $(PATSHOME) -o $@ $< -L $(PATSHOME)/libatsynmark -latsynmark
cleanall:: ; $(RMF) test1

test2: test2.dats
	$(ATSCC) -I$(PATSHOME)/src -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< -L $(PATSHOME)/libatsynmark -latsynmark
cleanall:: ; $(RMF) test2

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

