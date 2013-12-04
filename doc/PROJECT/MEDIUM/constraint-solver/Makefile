#
# A Simple Makefile
#

######

CCOPT=gcc -std=c99 -D_XOPEN_SOURCE -D_GNU_SOURCE 

######

PATSHOMEQ="$(PATSHOME)"
PATSHOMERELOCQ="$(PATSHOMERELOC)"

######

PATSCC=\
$(PATSHOMEQ)/bin/patscc \
  -atsccomp "$(CCOPT)" \
  -IIATS $(PATSHOME) \
  -IIATS $(PATSHOME)/ccomp/runtime \
  -IIATS $(PATSHOMERELOCQ)/contrib \

PATSOPT=$(PATSHOMEQ)/bin/patsopt

######

CFLAGS :=
CFLAGS += -I${PATSHOME}
CFLAGS += -I${PATSHOME}/ccomp/runtime
CFLAGS += $(shell pkg-config --cflags json-c)

######

LDFLAGS :=
LDFLAGS += -lgc
LDFLAGS += -L${PATSHOME}/ccomp/atslib/lib
LDFLAGS += -latslib
LDFLAGS += $(shell pkg-config --libs json-c)

######

all:: solver

######

solver: main_dats.o \
	constraint_dats.o \
	solver_mylib_dats.o 
	$(CCOPT) $(CFLAGS) -O2 -o $@ $^ $(LDFLAGS)

%_sats.o: %.sats ; $(PATSCC) $(CFLAGS) -c $<

%_dats.c: \
  %.dats solver.sats ; $(PATSCC) -ccats $<

%_dats.o: %_dats.c; $(PATSCC) $(DATSMEMALLOC) $(CFLAGS) -c $<

######
#
DATSMEMALLOC=-DATS_MEMALLOC_GCBDW
#
######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o
clean:: ; $(RMF) *_?ats.c
cleanall:: clean
cleanall:: ; $(RMF) solver

######

###### end of [Makefile] ######
