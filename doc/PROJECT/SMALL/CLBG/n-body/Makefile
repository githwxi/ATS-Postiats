######
#
# Makefile a CLBG benchmark
#
######

all: n-body

n-body: n-body.dats
	patscc -msse2 -mfpmath=sse -O3 n-body.dats -o n-body -lm

######

RMF=rm -f

######

.phony: clean

clean: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) n-body

###### end of [Makefile] ######
