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

hello: hello_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": not properly generated."

queens: queens_dats.c ; \
  $(CC) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": not properly generated."

######

%_dats.c: %.dats ; \
  $(PATSOPT) $(ATSCCFLAGS) -o $@ --dynamic $< || echo $@ ": not properly generated."

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
