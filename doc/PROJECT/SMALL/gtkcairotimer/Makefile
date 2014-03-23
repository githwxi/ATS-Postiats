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
  mytimer0.dats mytimer0_toplevel.dats $(GTKFLAGS) -lm -lrt
#
cleanall:: ; $(RMF) mytimer0
#
######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
