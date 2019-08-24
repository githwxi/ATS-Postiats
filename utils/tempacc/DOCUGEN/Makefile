######
#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSDOC=$(ATSHOME)/bin/atsdoc

######

all:: tempaccman.html

######

tempaccman: tempaccman_atxt.dats
	$(ATSCC) -o $@ tempaccman_atxt.dats -latsdoc
tempaccman.html: tempaccman; ./tempaccman > $@
tempaccman_atxt.dats: tempaccman.atxt
	$(ATSDOC) --outcode $@ -i tempaccman.atxt > tempaccman_atxt.txt

######

upload:: tempaccman.html
	scp -r $^ ats-hwxi,ats-lang@web.sourceforge.net:htdocs/RESOURCE/utils/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) tempaccman

cleanall:: clean
cleanall:: ; $(RMF) tempaccman.html

######
