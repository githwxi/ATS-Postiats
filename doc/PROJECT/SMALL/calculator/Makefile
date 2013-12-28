#
# A Simple Makefile
#

######

include $(PATSHOME)/share/atsmake-pre.mk

######

CCOMP=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

PATSCC2= $(PATSCC) -atsccomp "$(CCOMP)"

######

CFLAGS= -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime

######

SOURCES_SATS += \
  calculator.sats \

SOURCES_DATS += \
  calculator.dats \
  calculator_aexp.dats \
  calculator_token.dats \
  calculator_cstream.dats \
  calculator_tstream.dats \
  calculator_parsing.dats \
  calculator_print.dats \

######

include $(PATSHOME)/share/atsmake-post.mk

######

all:: calc
cleanall:: ; $(RMF) calc

######

OBJECTS= $(TARGETS_DATS_O)

######

calc: $(OBJECTS); \
  $(CCOMP) $(CFLAGS) -O2 -o $@ $^ -lgc -L$(PATSLIB) -latslib

######

%_dats.c: %.dats ; $(PATSCC) -ccats $<
%_dats.o: %_dats.c; $(PATSCC2) -DATS_MEMALLOC_GCBDW $(CFLAGS) -c $<

######

clean:: cleanats

###### end of [Makefile] ######
