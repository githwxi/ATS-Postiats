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

all:: libats_dllist
libats_dllist: libats_dllist.exe
libats_dllist.exe: libats_dllist_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libats_dllist_dats.c: libats_dllist.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dllist_dats.c --dynamic libats_dllist.dats
clean:: ; $(RMF) libats_dllist_dats.o
clean:: ; $(RMF) libats_dllist_dats.c
cleanall:: ; $(RMF) libats_dllist.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
