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

all::

######

HTMLGENDECL= \
  htmlgendecl_sats.o \
  htmlgendecl_dats.o \

htmlgendecl_sats.o: \
  htmlgendecl.sats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<
htmlgendecl_dats.o: \
  htmlgendecl.dats ; $(ATSCC) $(INCLUDE) $(INCLATS) -c $(ATSCCFLAGS) $<

######

htmlgendecl_atxt.dats: htmlgendecl.atxt ;   $(ATSDOC) --outcode $@ -i $< > htmlgendecl_atxt.txt

######

all:: list.html
list.html:   list_atxt.exe ; $(CAT) ../list.sats | ./$< > $@
list_atxt.txt: list.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __dtok --outcode htmlgendecl_data_atxt.dats > $@
list_atxt.exe:   htmlgendecl_atxt.dats list_atxt.txt $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) list_atxt.exe
cleanall:: ; $(RMF) list.html

all:: option.html
option.html:   option_atxt.exe ; $(CAT) ../option.sats | ./$< > $@
option_atxt.txt: option.atxt ;   $(CAT) $< | $(ATSDOC) --prefix __dtok --outcode htmlgendecl_data_atxt.dats > $@
option_atxt.exe:   htmlgendecl_atxt.dats option_atxt.txt $(HTMLGENDECL) ;   $(ATSCC) $(INCLUDE) $(INCLATS) -D_ATS_GCATS -o $@ $<     $(HTMLGENDECL) $(PATSHOME)/libatsyntax/libatsyntax.a -latsdoc
clean:: ; $(RMF) option_atxt.exe
cleanall:: ; $(RMF) option.html


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

###### end of [Makefile] ######
