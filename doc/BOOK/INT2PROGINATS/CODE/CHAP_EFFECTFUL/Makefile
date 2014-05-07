#
# A simple Makefile
#

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

INCLUDES=-I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime

######

CCFLAGS=-O2
ATSCCFLAGS=-D_GNU_SOURCE -DATS_MEMALLOC_LIBC

######

all:: misc
all:: brauntest
all:: insort
all:: counter
all:: permord
all:: montecarlo
all:: hello
all:: echoline

######

misc: misc_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: misc ; ./misc
cleanall:: ; $(RMF) misc

######

brauntest: \
brauntest_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: brauntest ; ./brauntest
cleanall:: ; $(RMF) brauntest

######

counter: counter_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: counter ; ./counter
cleanall:: ; $(RMF) counter

######

insort: insort_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: insort ; ./insort
cleanall:: ; $(RMF) insort

######

permord: permord_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: permord ; ./permord
cleanall:: ; $(RMF) permord

######

montecarlo: \
montecarlo_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< -lm || echo $@ ": ERROR!!!"
regress:: montecarlo ; ./montecarlo
cleanall:: ; $(RMF) montecarlo

######

hello: hello_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< || echo $@ ": ERROR!!!"
regress:: hello ; ./hello
cleanall:: ; $(RMF) hello hello.txt

######

echoline: \
echoline_dats.c ; \
  $(PATSCC) $(ATSCCFLAGS) $(INCLUDES) $(CCFLAGS) -o $@ $< -latslib || echo $@ ": ERROR!!!"
regress:: echoline ; $(CAT) echoline.dats | ./echoline > /dev/null
cleanall:: ; $(RMF) echoline

######

%_dats.c: %.dats ; $(PATSOPT) -o $@ --dynamic $< || echo $@ ": ERROR!!!"

#####

CAT=cat
RMF=rm -f
RMRF=rm -rf

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c

######

cleanall:: clean

######

###### end of [Makefile] ######
