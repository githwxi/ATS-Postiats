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
multest_client_dats.c: \
  multest_client.dats; $(PATSOPT) -o $@ -d $<
multest_client_dats.js: \
  multest_client_dats.c; $(ATSCC2JS) -o $@ -i $<
#
multest_server_dats.c: \
  multest_server.dats; $(PATSOPT) -o $@ -d $<
multest_server_dats.js: \
  multest_server_dats.c; $(ATSCC2JS) -o $@ -i $<
#
multest_server_dats_.js: \
  multest_server_dats.js; $(CAT) $(LIBATCC2JS)/libatscc2js_all.js $< > $@
#
######
#
upload_main: \
  main.html ; scp $^ \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/ssntyped-channels-1/.
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
cleanall:: ; $(RMF) multest_server_dats.js
cleanall:: ; $(RMF) multest_server_dats_.js
#
###### end of [Makefile] ######
