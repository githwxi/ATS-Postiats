######
#
# Makefile a CLBG benchmark
#
######

all:: pidigits

######

pidigits: pidigits.dats ; \
  patscc -I${PATSHOMERELOC}/contrib -O3 -fomit-frame-pointer -o pidigits pidigits.dats -lgmp

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) pidigits

###### end of [Makefile] ######
