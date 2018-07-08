#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

all:: test01
all:: test02

######
#
test01: \
test01.dats ; \
$(ATSCC) \
-I$(PATSHOME)/src \
-IATS $(PATSHOME) -o $@ $< \
-L ./../BUILD -L $(PATSLIB) -latsynmark -latsopt -lgmp
#
cleanall:: ; $(RMF) test01
#
######
#
test02: \
test02.dats ; \
$(ATSCC) \
-I$(PATSHOME)/src \
-IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< \
-L ./../BUILD -L $(PATSLIB) -latsynmark -latsopt -lgmp
#
cleanall:: ; $(RMF) test02
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c *_?ats.o

cleanall:: clean

###### end of [Makefile] ######

