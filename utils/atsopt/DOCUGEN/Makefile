######
#
# A simple Makefile
#
######

ATSCC=$(ATSHOME)/bin/atscc
ATSDOC=$(ATSHOME)/bin/atsdoc

######

all:: atsoptman.html

######

atsoptman: atsoptman_atxt.dats
	$(ATSCC) -o $@ atsoptman_atxt.dats -latsdoc
atsoptman_atxt.dats: atsoptman.atxt
	$(ATSDOC) --outcode $@ -i atsoptman.atxt > atsoptman_atxt.txt
atsoptman.html: atsoptman
	./atsoptman > $@

######

upload:: atsoptman.html
	scp -r $^ ats-hwxi,ats-lang@web.sourceforge.net:htdocs/RESOURCE/utils/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean
cleanall:: ; $(RMF) atsoptman
cleanall:: ; $(RMF) atsoptman.html

######
