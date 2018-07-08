#
# A simple Makefile
# for building libatscc2js_ext.js
#

######

CC=emcc
CCOMP=$(CC)

######
#
PATSCC=$(PATSHOME)/bin/patscc
PATSOPT=$(PATSHOME)/bin/patsopt
#
PATSRUNTIME=$(PATSHOME)/ccomp/runtime
#
######

CFLAGS += -DATS_MEMALLOC_LIBC
CFLAGS += -Wno-implicit-function-declaration

######

all:: libatscc2js_ext.o

######

CATSPARSEMIT=./../../CATS-parsemit

######

OBJECTS := \
  main0_dats.o \
  catsparse_sats.o \
  catsparse_all_dats.o \
  atscc2js_main_dats.o \
  atscc2js_emit_dats.o \
  atscc2js_emit2_dats.o \

######
#
libatscc2js.o: $(OBJECTS); $(CCOMP) -o $@ $^
#
libatscc2js_ext.o: \
  libatscc2js.o libatscc2js_ext_dats.o ; $(CCOMP) -o $@ $^
#
######
#
main0_dats.c: main0.dats; $(PATSOPT) -o $@ -d $<
#
main0_dats.o: \
main0_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
catsparse_sats.o: \
./../catsparse_sats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
catsparse_all_dats.o: \
$(CATSPARSEMIT)/CATS/catsparse_all_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
######
#
atscc2js_main_dats.o: \
./../atscc2js_main_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
atscc2js_emit_dats.o: \
./../atscc2js_emit_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
atscc2js_emit2_dats.o: \
./../atscc2js_emit2_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
libatscc2js_ext_dats.o: \
./../libatscc2js_ext_dats.c; \
$(CCOMP) -O2 $(CFLAGS) -I$(PATSHOME) -I$(PATSRUNTIME) -c -o $@ $<
#
######

RMF=rm -f
MAKE=make

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.c
clean:: ; $(RMF) *_?ats.o

######

cleanall:: clean
cleanall:: ; $(RMF) libatscc2js.o
cleanall:: ; $(RMF) libatscc2js_ext.o

###### end of [Makefile] ######
