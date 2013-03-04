#
#
# This Makefile is automatically generated
# from executing the following command-line:
#
# make -f Makefile.gen
#
#

######

ATSHOMEQ="$(ATSHOME)"
ATSCC=$(ATSHOMEQ)/bin/atscc
ATSOPT=$(ATSHOMEQ)/bin/atsopt
ATSDOC=$(ATSHOMEQ)/bin/atsdoc

######

GCC=gcc
PATSHOMEQ="$(PATSHOME)"
PATSOPT=$(PATSHOMEQ)/src/patsopt

######

ATSGCFLAG=-D_ATS_GCATS

######

all::

######

LNS=ln -s
RMF=rm -f

######

all:: prelude_string
prelude_string: prelude_string.exe
prelude_string.exe: prelude_string_dats.c ;   $(GCC) -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
prelude_string_dats.c: prelude_string.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output prelude_string_dats.c --dynamic prelude_string.dats
clean:: ; $(RMF) prelude_string_dats.o
clean:: ; $(RMF) prelude_string_dats.c
cleanall:: ; $(RMF) prelude_string.exe


######

all:: libats_qlist
libats_qlist: libats_qlist.exe
libats_qlist.exe: libats_qlist_dats.c ;   $(GCC) -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libats_qlist_dats.c: libats_qlist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_qlist_dats.c --dynamic libats_qlist.dats
clean:: ; $(RMF) libats_qlist_dats.o
clean:: ; $(RMF) libats_qlist_dats.c
cleanall:: ; $(RMF) libats_qlist.exe

all:: libats_dllist
libats_dllist: libats_dllist.exe
libats_dllist.exe: libats_dllist_dats.c ;   $(GCC) -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libats_dllist_dats.c: libats_dllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dllist_dats.c --dynamic libats_dllist.dats
clean:: ; $(RMF) libats_dllist_dats.o
clean:: ; $(RMF) libats_dllist_dats.c
cleanall:: ; $(RMF) libats_dllist.exe


######

all:: libats_ML_string0
libats_ML_string0: libats_ML_string0.exe
libats_ML_string0.exe: libats_ML_string0_dats.c ;   $(GCC) -O2 -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libats_ML_string0_dats.c: libats_ML_string0.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_ML_string0_dats.c --dynamic libats_ML_string0.dats
clean:: ; $(RMF) libats_ML_string0_dats.o
clean:: ; $(RMF) libats_ML_string0_dats.c
cleanall:: ; $(RMF) libats_ML_string0.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
