#
# A simple Makefile
#
######
#
ATSCC=$(ATSHOME)/bin/atscc
ATSDOC=$(ATSHOME)/bin/atsdoc
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
LIBATCC2JS=$(PATSHOMERELOC)/contrib/libatscc/libatscc2js
#
######

all:: main.html

######
#
main.exe: \
  main_atxt.dats ; \
  $(ATSCC) \
  -IATS $(PATSHOME) -IATS $(ATSHOME) \
  -I$(PATSHOME)/src -D_ATS_GCATS -o $@ $< \
  -L$(PATSHOME)/utils/libatsynmark -latsynmark -latsdoc
#
main.html: main.exe ; ./main.exe > $@
#
main_atxt.dats: \
  main.atxt; $(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
#
######

HanoiTowers-1: HanoiTowers-1.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
HanoiTowers-2: HanoiTowers-2.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
HanoiTowers-3: HanoiTowers-3.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

HanoiTowers_txt_dats.c: \
  HanoiTowers_txt.dats; $(PATSOPT) -o $@ -d $<
HanoiTowers_txt_dats.js: \
  HanoiTowers_txt_dats.c; $(ATSCC2JS) -o $@ -i $<

######
#
upload_main: \
  main.html ; scp $^ \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/HanoiTowers/.
#
upload_dats_js: \
  HanoiTowers_txt_dats.js ; scp $^ \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/HanoiTowers/.
#
######

CAT=cat
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) main_atxt.txt
clean:: ; $(RMF) main_atxt.dats

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) *_?ats.html
#
cleanall:: ; $(RMF) HanoiTowers-1
cleanall:: ; $(RMF) HanoiTowers-2
cleanall:: ; $(RMF) HanoiTowers-3
cleanall:: ; $(RMF) HanoiTowers_txt_dats.js
#
###### end of [Makefile] ######
