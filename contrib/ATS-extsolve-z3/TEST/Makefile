#
# A simple Makefile
#

######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
PATSOLVE=../patsolve_z3
#
######
#
all:: fib
#
fib:: fib.dats; $(PATSCC) --constraint-ignore -o $@ $<
#
fib:: \
fib.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i
#
regress:: fib; ./fib 20
#
cleanall:: ; $(RMF) fib
#
######
#
all:: fib2
#
fib2:: fib2.dats; $(PATSCC) --constraint-ignore -o $@ $<
#
fib2:: \
fib2.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i
#
regress:: fib2; ./$< 20
#
cleanall:: ; $(RMF) fib2
#
######
#
all:: fact
#
fact:: fact.dats; $(PATSCC) --constraint-ignore -o $@ $<
#
fact:: \
fact.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i
#
regress:: fact; ./$< 10
#
cleanall:: ; $(RMF) fact
#
######
#
all:: fact2
#
fact2:: \
fact2.dats; $(PATSCC) --constraint-ignore -o $@ $<
fact2:: \
fact2.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i
#
regress:: fact2; ./$< 10
#
cleanall:: ; $(RMF) fact2
#
######

all:: \
gflist_insort
gflist_insort:: \
gflist_insort.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

######

all:: \
gfarray_insort
gfarray_insort:: \
gfarray_insort.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

######

all:: \
palindrome
palindrome:: \
palindrome.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i

######
#
all:: \
quadratic
quadratic:: \
quadratic.dats; \
$(PATSCC) --constraint-ignore -o $@ $< -lm
quadratic:: \
quadratic.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -
#
regress:: quadratic; ./$< 10
cleanall:: ; $(RMF) quadratic
#
######

all:: \
real_misc
real_misc:: \
real_misc.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -

######

all:: \
ConcurrentMedians
ConcurrentMedians:: \
ConcurrentMedians.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -

######

all:: \
ConcurrentAltitudes-1
ConcurrentAltitudes-1:: \
ConcurrentAltitudes-1.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -

all:: \
ConcurrentAltitudes-2
ConcurrentAltitudes-2:: \
ConcurrentAltitudes-2.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -

######

all:: \
Zoe-2016-09-11
Zoe-2016-09-11:: \
Zoe-2016-09-11.dats; \
$(PATSOPT) -tc --constraint-export -d $< | $(PATSOLVE) -i -

######

testall:: all
testall:: regress
testall:: cleanall

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
