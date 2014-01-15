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

all:: wordcnt
wordcnt: wordcnt.dats ; \
  $(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) wordcnt

######

all:: wordcnt2
wordcnt2: wordcnt2.dats ; \
  $(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) wordcnt2

######

all:: wordcnt_vt
wordcnt_vt: wordcnt_vt.dats ; \
  $(PATSCC2) $(MALLOCFLAG) $(CFLAGS) -o $@ $< $(LDFLAGS)
cleanall:: ; $(RMF) wordcnt_vt

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

main.exe: \
  main_atxt.dats ; \
  $(ATSCC) \
  -IATS $(PATSHOME) -IATS $(ATSHOME) \
  -I$(PATSHOME)/src -D_ATS_GCATS -o $@ $< \
  -L$(PATSHOME)/libatsynmark -latsynmark -latsdoc

main_atxt.dats: \
  main.atxt; $(ATSDOC) --outcode $@ -i main.atxt > main_atxt.txt
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

######

###### end of [Makefile] ######
