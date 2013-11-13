######
#
# Makefile a CLBG benchmark
#
######

all:: mandelbrot

######

mandelbrot: mandelbrot.dats ; patscc -O3 -msse2 -o $@ $<

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) mandelbrot

###### end of [Makefile] ######
