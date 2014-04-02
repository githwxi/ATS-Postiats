#
# A simple Makefile
#
#
include $(PATSHOME)/share/atsmake-pre.mk
#
include $(PATSHOME)/share/atsmake-post.mk
#
GTKFLAGS=`pkg-config gtk+-3.0 --cflags --libs`
#
all::\
QueenPuzzle_anim
QueenPuzzle_anim: \
  QueenPuzzle_anim.dats \
  ./../depth-first.dats \
  gtkcairotimer_toplevel.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $^ $(GTKFLAGS) -lm -lrt
cleanall:: ; $(RMF) QueenPuzzle_anim
#
all::\
QueenPuzzle_anim2
QueenPuzzle_anim2: \
  QueenPuzzle_anim2.dats ; \
  $(PATSCC2) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $^ $(GTKFLAGS) -lm -lrt
cleanall:: ; $(RMF) QueenPuzzle_anim2
#
cleanats:: ; $(RMF) *_?ats.c
#
###### end of [Makefile] ######
