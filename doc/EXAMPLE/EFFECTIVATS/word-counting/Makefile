#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -DATS_MEMALLOC_LIBC -O2

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: \
wordcnt
wordcnt: \
wordcnt.dats ; \
$(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: wordcnt ; ./$< < wordcnt.dats > /dev/null
cleanall:: ; $(RMF) wordcnt

######

all:: \
wordcnt2
wordcnt2: \
wordcnt2.dats ; \
$(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: wordcnt2 ; ./$< < wordcnt2.dats > /dev/null
cleanall:: ; $(RMF) wordcnt2

######

all:: \
wordcnt_vt
wordcnt_vt: \
wordcnt_vt.dats ; \
$(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
regress:: wordcnt_vt ; ./$< < wordcnt_vt.dats > /dev/null
cleanall:: ; $(RMF) wordcnt_vt

######
#
html:: wordcnt_dats.html
html:: wordcnt2_dats.html
html:: wordcnt_vt_dats.html
#
PATS2XHTML=$(PATSHOMEQ)/bin/pats2xhtml
%_sats.html: %.sats ; $(PATS2XHTML) -o $@ -s $<
%_dats.html: %.dats ; $(PATS2XHTML) -o $@ -d $<
#
######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

INPATH :=
INPATH += -I$(PATSHOME)/src
INPATH += -IATS $(PATSHOME) -IATS $(ATSHOME)

LDPATH :=
LDPATH += -L$(PATSHOME)/utils/libatsopt
LDPATH += -L$(PATSHOME)/utils/libatsynmark

LIBRARY :=
LIBRARY := -latsynmark -latsdoc -latsopt -lats -lgmp

######
#
main.exe: \
main_atxt.dats ; \
$(ATSCC) \
  -D_ATS_GCATS \
  $(INPATH) -o $@ $< $(LDPATH) $(LIBRARY)
#
main_atxt.dats: main.atxt; \
$(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
#
######

main.html: main.exe ; ./main.exe > $@

######

upload_main: \
  main.html ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

cleanats:: ; $(RMF) *_?ats.c
cleanats:: ; $(RMF) main_atxt.txt
cleanats:: ; $(RMF) main_atxt.dats

######

cleanall:: ; $(RMF) main.exe
cleanall:: ; $(RMF) main.html
cleanall:: ; $(RMF) *_?ats.html

######

###### end of [Makefile] ######
