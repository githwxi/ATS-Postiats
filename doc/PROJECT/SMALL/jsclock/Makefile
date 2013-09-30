#
# A Makefile for a javascript based clock written in ATS.
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc

######

## Set the C compiler to be emscripten
export PATSCCOMP := emcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -L${PATSHOME}/ccomp/atslib/lib -I${PATSHOME}/contrib

######

all:: myclock0.js

myclock0.js: myclock0.dats library.js
	@echo ${PATSCCOMP}
	$(PATSCC) -I${PATSHOME}/contrib --js-library library.js  -o $@ $<

.Phony: clean

clean: 
	rm myclock0.js myclock0.js.map myclock0_dats.c
