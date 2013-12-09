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

SOURCESsta := \
  DiningPhil2.sats \

SOURCESdyn := \
  DiningPhil2.dats \
  DiningPhil2_fork.dats \
  DiningPhil2_thread.dats \

######

OBJECTS := $(SOURCESdyn)
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

test: $(OBJECTS) ; \
  $(PATSCC) $(ATSCCFLAGS) -pthread -o $@ $^ -L$(PATSLIB) -latslib
cleanall:: ; $(RMF) test

######

#
# You may find these rules useful
#

%_sats.o: %.sats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC) -D_BSD_SOURCE -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

######

-include .depend

######

depend:: ; $(RMF) .depend
depend:: ; $(PATSOPT) --output-a .depend --depgen -s $(SOURCESsta)
depend:: ; $(PATSOPT) --output-a .depend --depgen -d $(SOURCESdyn)

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/


######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

cleanall:: clean
#cleanall:: ; $(RMF) .depend1
#cleanall:: ; $(RMF) .depend2

###### end of [Makefile] ######
