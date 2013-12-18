##
##
## A simple Makefile
##
##

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

ATSCCFLAGS=-O2 -DATS_MEMALLOC_GCBDW -IIATS $(PATSHOMERELOCQ)/contrib

######

all:: test_up
all:: test_dn

######

cleanall::

######

SOURCESsta := \
  msgchan.sats \

SOURCESdyn := \
  mylib.dats \
  msgchan.dats \
  redisContextSetup.dats \

######

OBJECTS := $(SOURCESdyn)
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

test_up: \
  test_up.dats $(OBJECTS) ; \
  $(PATSCC) $(ATSCCFLAGS) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_up

test_dn: \
  test_dn.dats $(OBJECTS) ; \
  $(PATSCC) $(ATSCCFLAGS) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_dn

######

%_sats.o: %.sats ; $(PATSCC) $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC) -D_BSD_SOURCE $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

######

-include .depend
depend:: ; $(RMF) .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -d test_up.dats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d test_dn.dats
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCESdyn)

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-redis/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
#cleanall:: ; $(RMF) .depend

###### end of [Makefile] ######
