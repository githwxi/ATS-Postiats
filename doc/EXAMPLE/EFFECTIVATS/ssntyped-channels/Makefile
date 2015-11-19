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
# all:: sstest_client_dats.js
# all:: sstest_server_dats_.js
#
######
#
sstest_client_dats.c: sstest_client.dats; $(PATSOPT) -o $@ -d $<
sstest_client_dats.js: sstest_client_dats.c; $(ATSCC2JS) -o $@ -i $<
#
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
cleanall:: ; $(RMF) sstest_client_dats.js
cleanall:: ; $(RMF) sstest_server_dats.js
cleanall:: ; $(RMF) sstest_server_dats_.js
#
###### end of [Makefile] ######
