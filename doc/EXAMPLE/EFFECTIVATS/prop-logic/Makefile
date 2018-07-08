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

INPATH :=
INPATH += -I$(PATSHOME)/src
INPATH += -IATS $(PATSHOME) -IATS $(ATSHOME)

LDPATH :=
LDPATH += -L$(PATSHOME)/utils/libatsopt
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
#
upload_main: \
  main.html ; scp $^ \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/prop-logic/.
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
###### end of [Makefile] ######
