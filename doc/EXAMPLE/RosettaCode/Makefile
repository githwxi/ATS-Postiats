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
Amicable_pairs
Amicable_pairs: \
Amicable_pairs.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Amicable_pairs; ./$<
cleanall:: ; $(RMF) Amicable_pairs
#
######
#
all:: \
Middle_three_digits
Middle_three_digits: \
Middle_three_digits.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Middle_three_digits; ./$<
cleanall:: ; $(RMF) Middle_three_digits
#
######
#
all:: \
Nested_function
Nested_function: \
Nested_function.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Nested_function; ./$<
cleanall:: ; $(RMF) Nested_function
#
######
#
all:: \
Penneys_game
Penneys_game: \
Penneys_game.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Penneys_game; ./$< HHH TTT
cleanall:: ; $(RMF) Penneys_game
#
######
#
all:: \
Playing_cards
Playing_cards: \
Playing_cards.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Playing_cards; ./$<
cleanall:: ; $(RMF) Playing_cards
#
######
#
all:: \
Primality_by_trial_division
Primality_by_trial_division: \
Primality_by_trial_division.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $< -lm
#
regress:: \
Primality_by_trial_division; ./$<
cleanall:: ; $(RMF) Primality_by_trial_division
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
Stream_Merge; ./$< DATA/Stream_Merge_0.txt DATA/Stream_Merge_1.txt
#
cleanall:: ; $(RMF) Stream_Merge
#
######

RMF=rm -f

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
