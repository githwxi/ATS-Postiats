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
  DiningPhil2.sats \

SOURCES_DATS += \
  DiningPhil2.dats \
  DiningPhil2_fork.dats \
  DiningPhil2_thread.dats \

######

include $(PATSHOME)/share/atsmake-post.mk

######

OBJECTS := $(TARGETS_DATS_O)

######

all:: test
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

upload_main: ; \
  scp main.html \
  ats-hwxi,ats-lang@web.sourceforge.net:htdocs/EXAMPLE/EFFECTIVATS/DiningPhil2/

######

clean:: cleanats

###### end of [Makefile] ######
