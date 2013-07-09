######
#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSDOC=$(ATSHOME)/bin/atsdoc

######

all:: atsccman.html

######

atsccman: atsccman_atxt.dats
	$(ATSCC) -o $@ atsccman_atxt.dats -latsdoc
atsccman_atxt.dats: atsccman.atxt
	$(ATSDOC) --outcode $@ -i atsccman.atxt > atsccman_atxt.txt
atsccman.html: atsccman
	./atsccman > $@

######

upload:: atsccman.html
	scp -r $^ ats-hwxi,ats-lang@web.sourceforge.net:htdocs/RESOURCE/utils/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) atsccman

cleanall:: clean
cleanall:: ; $(RMF) atsccman.html

######
