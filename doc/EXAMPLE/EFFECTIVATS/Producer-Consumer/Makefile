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
  sbuffer.sats \

SOURCESdyn := \
  sbuffer.dats \

######

OBJECTS := $(SOURCESdyn)
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

test: $(OBJECTS)

######

#
# You may find these rules useful
#

%_sats.o: %.sats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC) -D_BSD_SOURCE -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

######

depend:: ; $(PATSOPT) -o .depend1 --depgen -s $(SOURCESsta)
depend:: ; $(PATSOPT) -o .depend2 --depgen -d $(SOURCESdyn)
-include .depend1
-include .depend2

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/Producer-Consumer/

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
