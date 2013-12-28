#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

all:: postfix_eval
postfix_eval: postfix_eval.dats; $(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
cleanall:: ; $(RMF) postfix_eval

######

include $(PATSHOME)/share/atsmake-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/stack-array/

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######