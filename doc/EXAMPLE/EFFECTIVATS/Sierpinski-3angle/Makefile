#
# A simple Makefile
#

######

PHP=php

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
ATSCC2JS=$(PATSHOME)/bin/atscc2js

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

Sierpinski-3angle.js: \
Sierpinski-3angle_dats.c; $(ATSCC2JS) -o $@ -i $<
Sierpinski-3angle_dats.c: \
Sierpinski-3angle-final.dats; $(PATSOPT) -o $@ -d $<

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Sierpinski-3angle/

######

upload_Sierpinski-3angle_js: \
  main.html ; \
  scp Sierpinski-3angle.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Sierpinski-3angle/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) Sierpinski-3angle.js

######

###### end of [Makefile] ######
