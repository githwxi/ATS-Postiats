#
# A Makefile for gtkcairoclock
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

MYTARGET=MYTARGET
MYCCRULE=MYCCRULE

######

include $(PATSHOME)/share/atsmake-post.mk

######

GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`

######
#
all:: test_gtkcairotimer
#
test_gtkcairotimer: \
  test_gtkcairotimer.dats ; \
  $(PATSCC2) \
  -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ \
  ./../DATS/gtkcairotimer/the_timer.dats \
  ./../DATS/gtkcairotimer/the_nclick.dats \
  ./../DATS/gtkcairotimer/the_topwin.dats \
  ./../DATS/gtkcairotimer/gtkcairotimer_main.dats \
  test_gtkcairotimer.dats $(GTKFLAGS) -lm -lrt
#
cleanall:: ; $(RMF) test_gtkcairotimer
#
######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
