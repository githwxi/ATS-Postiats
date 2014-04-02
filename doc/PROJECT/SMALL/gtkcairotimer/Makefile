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
all:: mytimer0
#
mytimer0: \
  mytimer0.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ \
  mytimer0.dats gtkcairotimer_toplevel.dats $(GTKFLAGS) -lm -lrt
#
cleanall:: ; $(RMF) mytimer0
#
######
#
all:: mytimer1
#
mytimer1: \
  mytimer1.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ \
  mytimer1.dats gtkcairotimer_toplevel.dats $(GTKFLAGS) -lm -lrt
#
cleanall:: ; $(RMF) mytimer1
#
######
#
all:: mytimer1-all
#
mytimer1-all: \
  mytimer1-all.dats ; \
  $(PATSCC2) -DATS_MEMALLOC_LIBC -D_GNU_SOURCE -o $@ $< $(GTKFLAGS) -lm -lrt
#
cleanall:: ; $(RMF) mytimer1-all
#
######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
