#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: quicksort_anim.js

######

export PATSCCOMP := emcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

quicksort_anim.js: quicksort_anim.dats ; \
  $(PATSCC) --js-library random.js --js-library animate.js \
	--js-library ${PATSHOME}/contrib/HTML/canvas-2d/JS/HTMLcanvas2d.js \
	-DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -o $@ $<

######

.phony: clean

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *.map

cleanall:: clean
cleanall:: ; rm -f quicksort_anim.js

###### end of [Makefile] ######
