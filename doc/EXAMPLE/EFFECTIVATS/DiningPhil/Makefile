##
##
## A simple Makefile
##
##

######

include $(PATSHOME)/share/atsmake-pre.mk

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

SOURCES_SATS += \
  DiningPhil.sats \

SOURCES_DATS += \
  DiningPhil.dats \
  DiningPhil_fork.dats \
  DiningPhil_dine.dats \
  DiningPhil_think.dats \

######

OBJECTS := $(SOURCES_DATS)
OBJECTS := $(patsubst %.dats, %_dats.o, $(OBJECTS))

######

all:: test
test: $(OBJECTS) ; \
  $(PATSCC) $(ATSCCFLAGS) -o $@ $^ -L$(PATSLIB) -lrt -latslib
cleanall:: ; $(RMF) test

######

#
# You may find these rules useful
#

%_sats.o: %.sats ; $(PATSCC) -DATS_MEMALLOC_LIBC -c $< || echo $@ ": ERROR!!!"
%_dats.o: %.dats ; $(PATSCC) -D_BSD_SOURCE -DATS_MEMALLOC_LIBC $(ATSCCFLAGS) -c $< || echo $@ ": ERROR!!!"

######

include $(PATSHOME)/share/atsmake-post.mk

######

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil/

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c

######

###### end of [Makefile] ######
