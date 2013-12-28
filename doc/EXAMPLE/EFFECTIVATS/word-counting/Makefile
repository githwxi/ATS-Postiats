#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

PATSCC2=$(PATSCC) -DATS_MEMALLOC_LIBC -O2

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: wordcnt
wordcnt: wordcnt.dats ; \
  $(PATSCC2) -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) wordcnt

######

all:: wordcnt2
wordcnt2: wordcnt2.dats ; \
  $(PATSCC2) -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) wordcnt2

######

all:: wordcnt_vt
wordcnt_vt: wordcnt_vt.dats ; \
  $(PATSCC2) -o $@ $< -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) wordcnt_vt

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/word-counting/

######

clean:: cleanats

######

###### end of [Makefile] ######
