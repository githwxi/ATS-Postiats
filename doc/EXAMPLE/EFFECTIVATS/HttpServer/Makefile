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

all:: \
myserver
myserver: \
myserver.dats; $(PATSCC) -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) myserver

######

all:: \
myserver2
myserver2: myserver2.dats ; \
  $(PATSCC) -D_GNU_SOURCE -I${PATSHOME}/contrib -o $@ $< -lczmq -lzmq
cleanall:: ; $(RMF) myserver2

######

all:: \
main.html
main.html: main_html.php; $(PHP) -f $< > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/HttpServer/

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
