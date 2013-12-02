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
all:: reader1
all:: xpath1
all:: xpath2

######

reader1: reader1.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) reader1

######

xpath1: xpath1.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) xpath1

######

xpath2: xpath2.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) xpath2

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean

######

###### end of [Makefile] ######