##
##
## A simple Makefile
##
##

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -DATS_MEMALLOC_GCBDW -IIATS $(PATSHOMERELOCQ)/contrib -O2

######

SOURCES_SATS += \
  msgchan.sats \

SOURCES_DATS += \
  mylib.dats \
  msgchan.dats \
  redisContextSetup.dats \

######

OBJECTS := $(SOURCES_DATS)
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

all:: test_up
test_up: test_up.dats $(OBJECTS) ; $(PATSCC2) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_up

all:: test_dn
test_dn: test_dn.dats $(OBJECTS) ; $(PATSCC2) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_dn

######

%_sats.o: %.sats ; $(PATSCC2) -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC2) -D_BSD_SOURCE -c $< || echo $@ ": ERROR!!!"

######

include $(PATSHOME)/share/atsmake-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-redis/

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
