######
#
# Makefile a CLBG benchmark
#
######

all:: fasta

######

fasta: fasta.dats ; \
  patscc -D_BSD_SOURCE -O3 -msse2 -mfpmath=sse -o fasta fasta.dats

######

RMF=rm -f

######

.phony: clean

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_dats.c

cleanall:: clean
cleanall:: ; $(RMF) fasta

###### end of [Makefile] ######
