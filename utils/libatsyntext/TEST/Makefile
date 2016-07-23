#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc

######

all::
all:: test01
all:: test02

######
#
test01: \
test01.dats ; \
$(ATSCC) \
  -I$(PATSHOME)/src \
  -IATS $(PATSHOME) -IATS $(ATSHOME) -o $@ $< \
  -L $(PATSHOME)/utils/libatsyntext -latsyntext -L $(PATSHOME)/utils/libatsopt -latsopt -lgmp
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
  -L $(PATSHOME)/utils/libatsyntext -latsyntext -L $(PATSHOME)/utils/libatsopt -latsopt -lgmp
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

