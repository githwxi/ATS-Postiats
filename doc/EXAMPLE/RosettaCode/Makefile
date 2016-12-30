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
Nested_function
Nested_function: \
Nested_function.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: \
Nested_function; ./$<
cleanall:: ; $(RMF) Nested_function
#
######
#
all:: \
Playing_cards
Playing_cards: \
Playing_cards.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: \
Playing_cards; ./$<
cleanall:: ; $(RMF) Playing_cards
#
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
#
all:: \
Stream_Merge
Stream_Merge: \
Stream_Merge.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -latslib
#
regress:: \
Stream_Merge; ./$<
cleanall:: ; $(RMF) Stream_Merge
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
