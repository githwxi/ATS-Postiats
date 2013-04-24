#
#
#

CCOPT=gcc
PATSOPT=$(PATSHOME)/bin/patsopt

######

all::
all:: P1
all:: P16

######

cleanall::

######

P1:: problem1-hwxi
problem1-hwxi:: \
  P1/problem1-hwxi.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem1-hwxi:: problem1-hwxi_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem1-hwxi:: problem1-hwxi.exe ; ./$<

P1:: problem1-hwxi2
problem1-hwxi2:: \
  P1/problem1-hwxi2.dats ; $(PATSOPT) -o $@_dats.c -d $<
problem1-hwxi2:: problem1-hwxi2_dats.c ; \
  $(CCOPT) -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -o $@.exe $@_dats.c
problem1-hwxi2:: problem1-hwxi2.exe ; ./$<

######

P16:: problem16-hwxi
problem16-hwxi:: \
  P16/problem16-hwxi.dats ; $(PATSOPT) -IATS${PATSHOME}/contrib -o $@_dats.c -d $<
problem16-hwxi:: \
  problem16-hwxi_dats.c ; \
  $(CCOPT) -DATS_MEMALLOC_LIBC \
  -I$(PATSHOME) -I$(PATSHOME)/ccomp/runtime -I${PATSHOME}/contrib -o $@.exe $@_dats.c -lgmp
problem16-hwxi:: problem16-hwxi.exe ; ./$<

######

RMF=rm -f

######

clean:: ; $(RMF) *~
clean:: ; $(RMF) */*~
clean:: ; $(RMF) *_dats.c
cleanall:: clean
cleanall:: ; $(RMF) *.exe

######
