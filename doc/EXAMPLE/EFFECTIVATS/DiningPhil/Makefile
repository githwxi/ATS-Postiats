##
##
## A simple Makefile
##
##

######

PATSHOMEQ="$(PATSHOME)"

######

PATSCC=$(PATSHOMEQ)/bin/patscc
PATSOPT=$(PATSHOMEQ)/bin/patsopt
PATSLIB=$(PATSHOMEQ)/ccomp/atslib/lib

######

#
# HX: Please uncomment the one you want, or skip it entirely
#
ATSCCFLAGS=
ATSCCFLAGS=-O2
#
# '-flto' enables link-time optimization such as inlining lib functions
#
#ATSCCFLAGS=-O2 -flto
#

######

all:: test

######

cleanall::

######

test: \
  DiningPhil_dats.o \
  DiningPhil_fork_dats.o \
  DiningPhil_eat_dats.o \
  DiningPhil_think_dats.o ; \
  $(PATSCC) $(ATSCCFLAGS) -o $@ $^ -L$(PATSLIB) -lrt -latslib || echo $@ ": ERROR!!!"
cleanall:: ; $(RMF) test

######

#
# You may find these rules useful
#

%_sats.o: %.sats ; $(PATSCC) $(ATSCCFLAGS) -DATS_MEMALLOC_LIBC -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC) $(ATSCCFLAGS) -DATS_MEMALLOC_LIBC -c $< || echo $@ ": ERROR!!!"

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean

###### end of [Makefile] ######
