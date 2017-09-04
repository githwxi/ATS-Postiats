######
#
# A simple Makefile
#
######

PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt

######

ATSRELOC1=$(PATSHOME)/bin/atsreloc_curl

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
Best_shuffle
Best_shuffle: \
Best_shuffle.dats ; \
$(PATSCC) -D_GNU_SOURCE -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Best_shuffle; ./$<
cleanall:: ; $(RMF) Best_shuffle
#
######
#
# all:: \
# Lucas-Lehmer_test
Lucas-Lehmer_test: \
Lucas-Lehmer_test.dats ; \
$(PATSCC) -O2 -I./PATSRELOCROOT -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
#
# regress:: \
# Lucas-Lehmer_test; ./$<
#
cleanall:: ; $(RMF) Lucas-Lehmer_test
#
######
#
all:: \
Lucas-Lehmer_test2
Lucas-Lehmer_test2: \
Lucas-Lehmer_test2.dats ; \
$(PATSCC) -O2 -I"$(PATSHOME)/contrib" -DATS_MEMALLOC_LIBC -o $@ $< -lgmp
#
regress:: \
Lucas-Lehmer_test2; ./$<
cleanall:: ; $(RMF) Lucas-Lehmer_test2
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
Pangram_checker
Pangram_checker: \
Pangram_checker.dats ; \
$(PATSCC) -DATS_MEMALLOC_LIBC -o $@ $<
#
regress:: \
Pangram_checker; ./$<
cleanall:: ; $(RMF) Pangram_checker
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

myatsreloc:: myatsreloc.dats; $(PATSOPT) --atsreloc -d $< | $(ATSRELOC1)

######

RMF=rm -f
RMRF=rm -rf

######

testall:: \
myatsreloc

######

testall:: all
testall:: regress
testall:: cleanall

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
cleanall:: ; $(RMRF) ./PATSRELOCROOT/*

###### end of [Makefile] ######
