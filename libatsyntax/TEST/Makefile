#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

test1: test1.dats
	$(ATSCC) -IATS $(PATSHOME) -o $@ $< -L $(PATSHOME)/libatsyntax -latsyntax
cleanall:: ; $(RMF) test1

test2: test2.dats
	$(ATSCC) -IATS $(PATSHOME) -o $@ $< -L $(PATSHOME)/libatsyntax -latsyntax
cleanall:: ; $(RMF) test2

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

