#
# A simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

all:: quicksort_anim.js

######

PATSCCOMP2=\
"emcc -Wno-warn-absolute-paths -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

######

quicksort_anim.js: \
  quicksort_anim.dats ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) \
     --js-library quicksort_anim_lib.js \
     --js-library ${PATSHOME}/contrib/HTML/JS/HTMLdocument.js \
     --js-library ${PATSHOME}/contrib/HTML/canvas-2d/JS/HTML5canvas2d.js \
     -DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -o $@ $<
cleanall:: ; $(RMF) quicksort_anim.js
cleanall:: ; $(RMF) quicksort_anim.js.map

######

upload:: ; scp quicksort_anim.html quicksort_anim.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JS/AlgoAnim/quicksort/

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *.map

######

cleanall:: clean

###### end of [Makefile] ######
