#
# A simple Makefile
#

######

CC=gcc
CCOPT=$(CC) -std=c99

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=

######

all:: hello
all:: queens

######

hello: hello_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: hello; ./hello
cleanall:: ; $(RMF) hello

queens: queens_dats.c ; \
  $(CCOPT) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: queens; ./queens
cleanall:: ; $(RMF) queens

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

######

###### end of [Makefile] ######
