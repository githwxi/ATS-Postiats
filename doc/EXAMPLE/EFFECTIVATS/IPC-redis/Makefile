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

MYTARGET=MYTARGET

######

MYCCRULE=MYCCRULE
include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS := $(MYTARGET_DATS_O)

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

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

main.exe: \
  main_atxt.dats ; \
  $(ATSCC) \
  -IATS $(PATSHOME) -IATS $(ATSHOME) \
  -I$(PATSHOME)/src -D_ATS_GCATS -o $@ $< \
  -L$(PATSHOME)/libatsynmark -latsynmark -latsdoc

main_atxt.dats: \
  main.atxt; $(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-redis/

######

cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats

######

cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html

###### end of [Makefile] ######
