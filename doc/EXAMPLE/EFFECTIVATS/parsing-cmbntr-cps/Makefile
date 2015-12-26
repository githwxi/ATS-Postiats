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
main_atxt.dats: \
  main.atxt; $(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
main.html: main.exe ; ./main.exe > $@
#
######
#
tokenizer: \
tokenizer.dats; \
$(PATSCC) \
  -D_GNU_SOURCE \
  -DATS_MEMALLOC_GCBDW -O2 -o $@ $< -latslib -lgc
#
######
#
regress: tokenizer; $(CAT) tokenizer.dats | ./tokenizer
#
######
#
upload_main: \
  main.html ; scp $^ \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/parsing-cmbntr-cps/.
#
######

CAT=cat
RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o
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
cleanall:: ; $(RMF) tokenizer
#
###### end of [Makefile] ######
