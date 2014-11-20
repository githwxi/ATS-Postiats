#
# A simple Makefile
#

######

PHP=php

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: \
main.html
main.html: main_html.php; $(PHP) -f $< > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Sierpinski-3angle/

######

cleanats:: ; $(RMF) *_?ats.c

######

cleanall:: ; $(RMF) main.html

######

###### end of [Makefile] ######
