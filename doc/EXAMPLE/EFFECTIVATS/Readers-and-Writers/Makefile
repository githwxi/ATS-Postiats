##
##
## A simple Makefile
##
##

######

include \
$(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS += -O2

######

SOURCES_SATS := \
  DB_read_write.sats \

SOURCES_DATS := \
  DB_read_write.dats \

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: test
test:: ; $(PATSCC) -tcats DB_read_write.sats
test:: ; $(PATSCC) -tcats DB_read_write.dats

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
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Readers-and-Writers/

######

cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats
cleanats:: ; $(RMF) main_atxt_dats.c

######

cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
