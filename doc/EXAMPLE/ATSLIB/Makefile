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

all:: libats_dlist_vt
libats_dlist_vt: libats_dlist_vt.exe
libats_dlist_vt.exe: libats_dlist_vt_dats.c ;   $(GCC) -I$(PATSHOMEQ) -I$(PATSHOMEQ)/ccomp/runtime -o $@ $<
libats_dlist_vt_dats.c: libats_dlist_vt.dats ;   $(PATSOPT) -IATS$(PATSHOMEQ)/contrib --output libats_dlist_vt_dats.c --dynamic libats_dlist_vt.dats
clean:: ; $(RMF) libats_dlist_vt_dats.o
clean:: ; $(RMF) libats_dlist_vt_dats.c
cleanall:: ; $(RMF) libats_dlist_vt.exe


######

clean:: ; $(RMF) *~
clean:: ; $(RMF) *_?ats.o *_?ats.c
clean:: ; $(RMF) *_atxt.txt
clean:: ; $(RMF) *_atxt.dats
clean:: ; $(RMF) Makefile.exe

cleanall:: clean

###### end of [Makefile] ######
