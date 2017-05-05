##
##
## A simple Makefile
##
##

######

PATSCONTRIBQ="$PATSCONTRIB"

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

PATSCC_2=\
$(PATSCC) \
$(INCLUDE) \
-DATS_MEMALLOC_GCBDW \
-IIATS $(PATSHOME)/npm-utils/contrib -O2

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

all:: \
test_up
test_up: \
test_up.dats $(OBJECTS) ; \
$(PATSCC_2) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_up

all:: \
test_dn
test_dn: \
test_dn.dats $(OBJECTS) ; \
$(PATSCC_2) -o $@ $^ -lhiredis -lgc
cleanall:: ; $(RMF) test_dn

######

%_sats.o: %.sats ; $(PATSCC_2) -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC_2) -D_BSD_SOURCE -c $< || echo $@ ": ERROR!!!"

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

INPATH :=
INPATH += -I$(PATSHOME)/src
INPATH += -IATS $(PATSHOME) -IATS $(ATSHOME)

LDPATH :=
LDPATH += -L$(PATSHOME)/ccomp/atslib/lib

LIBRARY :=
LIBRARY := -latsynmark -latsdoc -latsopt -lats -lgmp

######
#
main.exe: \
main_atxt.dats ; \
$(ATSCC) \
  -D_ATS_GCATS \
  $(INPATH) -o $@ $< $(LDPATH) $(LIBRARY)
#
main_atxt.dats: main.atxt; \
$(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
#
######

main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/IPC-hiredis/

######
#
# clean: cleanats
#
cleanats:: ; $(RMF) main.exe
cleanats:: ; $(RMF) mylib_dats.c
cleanats:: ; $(RMF) msgchan_dats.c
cleanats:: ; $(RMF) redisContextSetup_dats.c
cleanats:: ; $(RMF) test_up_dats.c
cleanats:: ; $(RMF) test_dn_dats.c
cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats
cleanats:: ; $(RMF) main_atxt_dats.c
#
######

cleanall:: ; $(RMF) main.html

###### end of [Makefile] ######
