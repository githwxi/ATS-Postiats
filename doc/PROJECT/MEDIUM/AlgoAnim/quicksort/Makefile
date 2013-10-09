#
# A simple Makefile
#

######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all:: quicksort_anim.js

######

PATSCCOMP2="emcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

######

quicksort_anim.js: quicksort_anim.dats ; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) \
        --js-library random.js --js-library animate.js \
	--js-library ${PATSHOME}/contrib/HTML5/canvas-2d/JS/HTMLcanvas2d.js \
	-DATS_MEMALLOC_LIBC -I${PATSHOME}/contrib -o $@ $<

######

upload:: ; scp quicksort_anim.html quicksort_anim.js \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/TEMPATS/JavaScripts/AlgoAnim/quicksort/

######

.phony: clean

clean:: ; rm -f *~
clean:: ; rm -f *_?ats.o
clean:: ; rm -f *_?ats.c
clean:: ; rm -f *.map

cleanall:: clean
cleanall:: ; rm -f quicksort_anim.js

###### end of [Makefile] ######
