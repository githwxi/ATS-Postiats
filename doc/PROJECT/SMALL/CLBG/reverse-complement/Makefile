######
#
# Makefile a CLBG benchmark
#
######

all:: reverse-complement

######

reverse-complement: \
  reverse-complement.dats ; patscc -O3 -fomit-frame-pointer -o $@ $<

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) reverse-complement

###### end of [Makefile] ######
