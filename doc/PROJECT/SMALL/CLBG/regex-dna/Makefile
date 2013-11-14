######
#
# Makefile a CLBG benchmark
#
######

all:: regex-dna

######

regex-dna: regex-dna.dats ; \
  patscc -DATS_MEMALLOC_LIBC -O3 -msse2 -mfpmath=sse -o $@ $< -lpcre

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) regex-dna

###### end of [Makefile] ######
