#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

test1: test1.dats
	$(ATSCC) -IATS $(PATSHOME) -o $@ test1.dats -L $(PATSHOME)/libatsyntax -latsyntax
cleanall:: ; $(RMF) test1

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

