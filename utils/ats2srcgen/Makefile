######
#
# Makefile for ats2srcgen
#
######

ATSHOMEQ="$(ATSHOME)"
PATSHOMEQ="$(PATSHOME)"

######

ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

INCLUDE:=-I $(PATSHOMEQ)/src
INCLATS:=-IATS $(PATSHOMEQ) -IATS $(ATSHOMEQ)

######

CCFLAGS=-fPIC -O2

######

all:: ats2srcgen

######

OBJECTS := \
  pats_utils_sats.o \
  pats_utils_dats.o \

######
##
ats2srcgen: $(OBJECTS) ; \
  $(ATSCC) -O2 $(INCLUDE) $(INCLATS) -o $@ $< $(OBJECTS) -lgmp
##
######
##
%_sats.o: \
  $(PATSHOME)/src/%.sats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
%_dats.o: \
  $(PATSHOME)/src/%.dats; $(ATSCC) $(INCLUDE) $(INCLATS) $(CCFLAGS) -c $<
##
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

###### end of [Makefile for ats2srcgen] ######
