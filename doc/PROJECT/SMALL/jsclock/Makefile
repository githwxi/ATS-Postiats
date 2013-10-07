#
# A Makefile for a javascript based clock written in ATS.
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc

######
##
## Set the C compiler to be emscripten
##
PATSCCOMP2=emcc -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime
##
######

all:: myclock0.js

myclock0.js: myclock0.dats
	@echo ${PATSCCOMP2}
	$(PATSCC) -atsccomp "$(PATSCCOMP2)" -I${PATSHOME}/contrib --js-library library.js  -o $@ $<

######

RMF=rm -f

######

.PHONY: clean

clean:: ; $(RMF) myclock0_dats.c

cleanall:: clean
cleanall:: ; $(RMF) myclock0.js myclock0.js.map

###### end of [Makefile] ######
