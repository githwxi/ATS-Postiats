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
PATSOLVE=$(PATSHOME)/bin/patsolve_z3
#
ATSCC2JS=$(PATSHOME)/bin/atscc2js
LIBATCC2JS=$(PATSCONTRIB)/contrib/libatscc/libatscc2js
#
######

all:: main.html
all:: HanoiTowers_txt_dats.js

######

INPATH :=
INPATH += -I$(PATSHOME)/src
INPATH += -IATS $(PATSHOME) -IATS $(ATSHOME)

LDPATH :=
LDPATH += -L$(PATSHOME)/ccomp/atslib/lib
LDPATH += -L$(PATSHOME)/utils/libatsynmark

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

HanoiTowers-1: HanoiTowers-1.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
HanoiTowers-2: HanoiTowers-2.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
HanoiTowers-3: HanoiTowers-3.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<

######

HanoiTowers-2-2:: \
HanoiTowers-2-2.dats; $(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i
HanoiTowers-3-2:: \
HanoiTowers-3-2.dats; $(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

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
clean:: ; $(RMF) main.exe
clean:: ; $(RMF) main_atxt.txt
clean:: ; $(RMF) main_atxt.dats

######
#
cleanall:: clean
#
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) *_?ats.html
#
cleanall:: ; $(RMF) HanoiTowers-1
cleanall:: ; $(RMF) HanoiTowers-2
cleanall:: ; $(RMF) HanoiTowers-3
cleanall:: ; $(RMF) HanoiTowers_txt_dats.js
#
###### end of [Makefile] ######
