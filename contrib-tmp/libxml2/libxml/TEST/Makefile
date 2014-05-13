#
# A Simple Makefile
#

######

CCOPT=gcc

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CFLAGS :=
CFLAGS += -I$(PATSHOMERELOCQ)/contrib 
CFLAGS += $(shell xml2-config --cflags)

######

LDFLAGS :=
LDFLAGS += $(shell xml2-config --libs)

######

all::
all:: reader1
all:: xpath1
all:: xpath2
all:: xpath3
all:: htmlParseDoc
all:: htmlTreeWalk

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

xpath3: xpath3.c
	$(CCOPT) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) xpath3

######

htmlParseDoc: htmlParseDoc.dats; \
  $(PATSCC) -DATS_MEMALLOC_LIBC $(CFLAGS) -O2 -o $@ $< $(LDFLAGS) -latslib
cleanall:: ; $(RMF) htmlParseDoc

######

htmlTreeWalk: htmlTreeWalk.dats; $(PATSCC) $(CFLAGS) -O2 -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) htmlTreeWalk

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
