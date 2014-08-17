#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all:: fcopy1
all:: fcopy2
all:: fcopy3

######

fcopy1: \
fcopy1.dats ; $(PATSCC) -o $@ $<
regress:: fcopy1 ; ./$< < fcopy1.dats > /dev/null
cleanall:: ; $(RMF) fcopy1

######

fcopy2: \
fcopy2.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: fcopy2 ; ./$< < fcopy2.dats > /dev/null
cleanall:: ; $(RMF) fcopy2

######

fcopy3: \
fcopy3.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
regress:: fcopy3 ; ./$< < fcopy3.dats > /dev/null
cleanall:: ; $(RMF) fcopy3

######

RMF=rm -f

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
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/file-copying/

######

cleanats:: ; $(RMF) *_?ats.o
cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats

######

clean: cleanats

######

cleanall:: cleanats
cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
