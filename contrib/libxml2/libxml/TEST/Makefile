#
# A Simple Makefile
#

######

CCOPT=gcc

######

CFLAGS :=
CFLAGS += $(shell xml2-config --cflags)

######

LDFLAGS :=
LDFLAGS += $(shell xml2-config --libs)

######

all::
all::xpath1
all::xpath2

######

xpath1: xpath1.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)

######

xpath2: xpath2.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) xpath1
cleanall:: ; $(RMF) xpath2

######

###### end of [Makefile] ######