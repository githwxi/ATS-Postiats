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

test01.js: \
  test01.dats; \
  $(PATSCC) -atsccomp $(PATSCCOMP2) --js-library ../JS/HTML5canvas2d.js -o $@ $<
cleanall:: ; $(RMF) test01.js
cleanall:: ; $(RMF) test01.js.map

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.dats

cleanall:: clean

######

###### end of [Makefile]
