######
#
# Makefile a CLBG benchmark
#
######

all:: fannkuch-redux

######

fannkuch-redux: fannkuch-redux.dats ; \
  patscc -DATS_MEMALLOC_LIBC -O3 -fomit-frame-pointer $< -o $@

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) fannkuch-redux

###### end of [Makefile] ######
