#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CFLAGS=$(shell pkg-config gtk+-3.0 --cflags)

######

LDFLAGS += -lgc
LDFLAGS += $(shell pkg-config gtk+-3.0 --libs)

######
#
all:: insertsort_anim
#
insertsort_anim: \
  ./../insertsort.dats \
  insertsort_anim.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $(CFLAGS) $^ $(LDFLAGS)
#
cleanall:: ; $(RMF) insertsort_anim
#
######
#
all:: insertsort_anim2
#
insertsort_anim2: \
  ./../insertsort.dats \
  insertsort_anim2.dats \
  gtkcairotimer_toplevel.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $(CFLAGS) $^ $(LDFLAGS)
#
cleanall:: ; $(RMF) insertsort_anim2
#
######
#
all:: \
insertsort_anim2_all
#
insertsort_anim2_all: \
  insertsort_anim2_all.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_GCBDW -O2 -o $@ $(CFLAGS) $^ $(LDFLAGS)
#
cleanall:: ; $(RMF) insertsort_anim2_all
#
######

include $(PATSHOME)/share/atsmake-post.mk

######

cleanats:: ; $(RMF) *_?ats.c

###### end of [Makefile] ######
