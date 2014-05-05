#
# A simple Makefile
#

######

CC=gcc -std=c99
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
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

queens: queens_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

######

regress: hello queens ; \
  ./hello && ./queens

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMF) hello
cleanall:: ; $(RMF) queens

######

###### end of [Makefile] ######
