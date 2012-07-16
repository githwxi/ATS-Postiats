#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

PATSHOMEQ="$(PATSHOME)"
INCLUDE=-I $(PATSHOMEQ)/src
INCLATS=-IATS $(PATSHOMEQ) -IATS $(PATSHOMEQ)/src

######

CAT=cat

######

all:: all_html

######

DECLATEXT= \
  declatext_sats.o \
  declatext_dats.o \

declatext_sats.o: \
  declatext.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
declatext_dats.o: \
  declatext.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

######

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: \
  htmlgendecl.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
htmlgendecl_dats.o: \
  htmlgendecl.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

htmlgendecl_atxt.dats: htmlgendecl.atxt ;   $(ATSDOC) --outcode $@ -i $< > htmlgendecl_atxt.txt

######

all_html::

######

uploadall:: ;   scp HTML/*.html ats-hwxi,ats-lang@web.sourceforge.net:htdocs/LIBRARY/libats/ML

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
