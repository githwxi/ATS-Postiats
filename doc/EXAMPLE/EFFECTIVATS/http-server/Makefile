#
# A simple Makefile
#

######

PHP=php

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
PATSLIB=$(PATSHOME)/ccomp/atslib/lib

######

MYTEXTING=./../MYTEXT/bin/mytexting

######
#
all:: \
main.html
main.html: \
main_html.atxt ; $(MYTEXTING) -o $@ -i $<
main_html.atxt: main_html.php; $(PHP) -f $< > $@
#
######

all:: \
myserver
myserver: \
myserver.dats; $(PATSCC) -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) myserver

######

all:: \
myserver2
myserver2: myserver2.dats ; \
  $(PATSCC) -D_GNU_SOURCE -I${PATSHOMERELOC}/contrib -o $@ $< -lczmq -lzmq
cleanall:: ; $(RMF) myserver2

######
#
upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/http-server/
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
