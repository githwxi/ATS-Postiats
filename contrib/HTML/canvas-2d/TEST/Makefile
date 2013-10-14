#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

PATSCCOMP2=\
"emcc -Wno-warn-absolute-paths -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

######

.PHONY: all

######

all:: test01.js
all:: quicksort_anim.js

######

test01.js: \
  test01.dats; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) \
    --js-library ../JS/HTML5canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test01.js
cleanall:: ; $(RMF) test01.js.map

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

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

######

cleanall:: clean

######

###### end of [Makefile]
