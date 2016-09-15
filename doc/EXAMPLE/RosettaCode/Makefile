######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::

######
#
all:: \
Remove_lines_from_a_file
Remove_lines_from_a_file: \
Remove_lines_from_a_file.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: \
Remove_lines_from_a_file; ./$< 1 7
cleanall:: ; $(RMF) Remove_lines_from_a_file
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
