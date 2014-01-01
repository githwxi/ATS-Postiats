#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc

######

all::tailrec

######

tailrec: tailrec.dats ; $(PATSCC) -tcats $@ $<

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
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/loop-as-tailrec/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) main_atxt.txt
clean:: ; $(RMF) main_atxt.dats

######

cleanall:: clean
cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
